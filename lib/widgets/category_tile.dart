import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/item_category.dart';
import 'category_view.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.currentCategoryList,
    required this.currentCategory,
  });

  final List<ItemCategory> currentCategoryList;
  final ItemCategory currentCategory;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
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
        CategoryView(itemList: currentCategory.items)
      ],
    );
  }
}