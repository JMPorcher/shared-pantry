import 'package:flutter/material.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/models/item_category.dart';
import 'package:shared_pantry/widgets/sp_cards.dart';
import 'package:shared_pantry/widgets/list_bottom_gradient.dart';

import '../dialogs/edit_category_dialog.dart';
import '../models/pantry.dart';
import '../widgets/add_category_button.dart';
import '../widgets/category_expansion_tile.dart';

class PantryScreen extends StatelessWidget {
  const PantryScreen({required this.currentPantry, Key? key}) : super(key: key);

  final Pantry currentPantry;

  @override
  Widget build(BuildContext context) {
    final List<ItemCategory> currentCategoryList = currentPantry.categories;

    return Column(
        children: [
          SpCard.pantry(currentPantry, isSelected: false),
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double stackHeight = constraints.maxHeight;

                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // Categories
                    Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
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
                    LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        double columnHeight = constraints.maxHeight;
                        if (columnHeight > stackHeight) {
                          return const Align(
                              alignment: Alignment.bottomCenter,
                              child: ListBottomGradient());
                        } else {
                          return const SizedBox();
                        }

                      },
                    ),
                  ]); },
            ),
          )
        ],
      );
  }
}
//TODO Add ValueNotifier construction to make dynamic checks for the height of column and stack and show/hide bottom gradient accordingly."