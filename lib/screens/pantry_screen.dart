import 'package:flutter/material.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/models/item_category.dart';
import 'package:shared_pantry/screens/no_categories_splash_screen.dart';
import 'package:shared_pantry/widgets/sp_cards.dart';

import '../dialogs/edit_category_dialog.dart';
import '../models/pantry.dart';
import '../widgets/add_button.dart';
import '../widgets/category_expansion_tile.dart';

class PantryScreen extends StatelessWidget {
  const PantryScreen({required this.currentPantry, super.key});

  final Pantry currentPantry;

  @override
  Widget build(BuildContext context) {
    final List<ItemCategory> currentCategoryList = currentPantry.categories;

    return Column(
        children: [
          SpCard.pantry(currentPantry, isSelected: false),
          Expanded(
            child: Column(
              children: [
               Expanded(
                  child:  currentCategoryList.isEmpty
                ? const NoCategoriesSplashScreen()
                : ListView.builder(
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
                AddButton.category(currentCategoryList: currentCategoryList),
              ],
            ),
          )
        ],
      );
  }
}