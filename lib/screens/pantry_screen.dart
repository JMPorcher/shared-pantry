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

    GlobalKey stackKey = GlobalKey();
    GlobalKey categoryColumnKey = GlobalKey();



    return Column(
        children: [
          SpCard.pantry(currentPantry, isSelected: false),
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double categoryColumnHeight = constraints.maxHeight;
                double stackHeight = stackKey.currentContext?.findRenderObject()?.paintBounds.height ?? 0.0;

                stackHeightNotifier.value = stackHeight;
                categoryColumnHeightNotifier.value = categoryColumnHeight;
                categoryColumnHeightNotifier.addListener(() {

                });


                return Stack(
                  key: stackKey,
                  alignment: Alignment.bottomCenter,
                  children: [
                    // Categories
                    Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            key: categoryColumnKey,
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
                    ValueListenableBuilder(
                      valueListenable: showGradientShadow,
                      builder: (BuildContext context, bool value, Widget? child) {
                        return LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {

                            if (categoryColumnHeight > stackHeight) {
                              showGradientShadow.value = true;
                            } else {
                              showGradientShadow.value = false;
                            }

                            if (showGradientShadow.value) {
                              return const Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ListBottomGradient());
                            } else {
                              return const SizedBox();
                            }
                          },
                        );
                      },

                    ),
                  ]); },
            ),
          )
        ],
      );
  }
}