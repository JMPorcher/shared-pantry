import 'package:flutter/material.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/models/item_category.dart';
import 'package:shared_pantry/widgets/cards.dart';
import 'package:shared_pantry/widgets/list_bottom_gradient.dart';

import '../dialogs/edit_category_dialog.dart';
import '../models/pantry.dart';
import '../widgets/add_category_button.dart';
import '../widgets/category_expansion_tile.dart';

class PantryScreen extends StatelessWidget {
  const PantryScreen({required this.currentPantry, Key? key})
      : super(key: key);

  final Pantry currentPantry;

  @override
  Widget build(BuildContext context) {
    final List<ItemCategory> currentCategoryList = currentPantry.categories;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children:
        [ListView(
          children: [
            PantryCard.pantry(currentPantry),
            // Categories
            Column(
              children: List.generate(
                currentCategoryList.length,
                    (index) {
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
            // Button at the bottom
            AddCategoryButton(currentCategoryList: currentCategoryList),
          ],
        ),
        const ListBottomGradient()
        ]
      ),
    );
  }
}



