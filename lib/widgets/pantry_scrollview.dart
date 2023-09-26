import 'package:flutter/material.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/models/item_category.dart';
import 'package:shared_pantry/widgets/pantry_appbar.dart';

import '../dialogs/edit_category_dialog.dart';
import '../models/pantry.dart';
import 'add_category_button.dart';
import 'category_expansion_tile.dart';

class PantryScrollView extends StatelessWidget {
  const PantryScrollView({required this.currentPantry, Key? key})
      : super(key: key);

  final Pantry currentPantry;

  @override
  Widget build(BuildContext context) {
    final List<ItemCategory> currentCategoryList = currentPantry.categories;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PantryAppBar(currentPantry: currentPantry),
      body: ListView(
        children: [
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
    );
  }
}



