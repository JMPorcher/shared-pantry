import 'package:flutter/material.dart';

import '../constants.dart';
import '../dialogs/edit_category_dialog.dart';
import '../models/item_category.dart';
import 'category_item_view.dart';

class CategoryExpansionTile extends StatelessWidget {
  const CategoryExpansionTile(
      this.currentCategory,
      {super.key, required this.itemCategoryList}
  );

  final ItemCategory currentCategory;
  final List<ItemCategory> itemCategoryList;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColor1,
      margin: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onLongPress: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => EditCategoryDialog(
              itemCategoryList: itemCategoryList,
              itemCategory: currentCategory,
            ),
          );
        },
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: ExpansionTile(
            initiallyExpanded:
            currentCategory.isExpanded,
            onExpansionChanged: (_) {
              currentCategory
                  .toggleExpanded();
            },
            title: Center(
                child: Text(
                  currentCategory.title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                )),
            backgroundColor: kColor11,
            collapsedBackgroundColor: kColor11,
            children: [
              CategoryItemView(itemList: currentCategory)
            ],
          ),
        ),
      ),
    );
  }
}