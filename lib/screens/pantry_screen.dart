import 'package:flutter/material.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/models/item_category.dart';
import 'package:shared_pantry/widgets/sp_cards.dart';

import '../dialogs/edit_category_dialog.dart';
import '../models/pantry.dart';
import '../widgets/add_category_button.dart';
import '../widgets/category_expansion_tile.dart';

class PantryScreen extends StatelessWidget {
  PantryScreen({required this.currentPantry, Key? key}) : super(key: key);

  final Pantry currentPantry;

  final ValueNotifier<bool> showGradientShadow = ValueNotifier(false);

  final ValueNotifier<double> categoryColumnHeightNotifier = ValueNotifier(0.0);
  final ValueNotifier<double> stackHeightNotifier = ValueNotifier(0.0);


  @override
  Widget build(BuildContext context) {
    final List<ItemCategory> currentCategoryList = currentPantry.categories;
    final ScrollController scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        showGradientShadow.value = false;
      } else {
        showGradientShadow.value = true;
      }
    });

    return Column(
        children: [
          SpCard.pantry(currentPantry, isSelected: false),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    itemCount: currentCategoryList.length,
                    itemBuilder: (context, index) {
                      ItemCategory currentCategory = currentCategoryList[index];
                      return Container(
                        color: kColor1,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => EditCategoryDialog(
                                itemCategoryList: currentCategoryList,
                                itemCategory: currentCategory,
                              ),
                            );
                          },
                          child: CategoryExpansionTile(
                            currentCategoryList: currentCategoryList,
                            currentCategory: currentCategory,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                AddCategoryButton(currentCategoryList: currentCategoryList),
              ],
            ),
          )
        ],
      );
  }
}