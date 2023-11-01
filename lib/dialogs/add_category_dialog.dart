import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/item_category.dart';
import '../providers/pantry_provider.dart';

class AddCategoryDialog extends StatelessWidget {
    AddCategoryDialog(this.currentCategoryList, { super.key, });

    final List<ItemCategory> currentCategoryList;

    final ValueNotifier<String> categoryTitleValueNotifier = ValueNotifier<String>('');
    final titleTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleTextController.text = categoryTitleValueNotifier.value;

    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [AlertDialog(
            title: const Text('Add item category to your pantry:'),
            content: TextField(
              controller: titleTextController,
              autofocus: true,
            ),
            actions: [
              TextButton(
                  onPressed: () {Navigator.pop(context);},
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    final String categoryTitle = titleTextController.text;
                    if (categoryTitle != '') {
                      context.read<PantryProvider>().addCategory(currentCategoryList, ItemCategory(categoryTitle));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add'))
            ]),]
    );
  }
}