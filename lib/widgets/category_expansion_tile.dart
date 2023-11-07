import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/item_category.dart';
import 'category_view.dart';

class CategoryExpansionTile extends StatelessWidget {
  const CategoryExpansionTile(
      this.currentCategory,
      {super.key}
  );

  final ItemCategory currentCategory;

  @override
  Widget build(BuildContext context) {
    return Card(
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
          CategoryView(itemList: currentCategory)
        ],
      ),
    );
  }
}