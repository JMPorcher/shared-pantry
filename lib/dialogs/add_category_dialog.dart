import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/constants.dart';

import '../models/item_category.dart';
import '../providers/category_list_provider.dart';

class AddCategoryDialog extends StatefulWidget {
  const AddCategoryDialog({super.key});

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  bool itemInStock = false;
  String categoryTitle = '';

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [AlertDialog(
            title: const Text('Add item category to your pantry:'),
            content: TextField(
              autofocus: true,
              onChanged: (newString) {
                setState(() {
                  categoryTitle = newString;
                });
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {Navigator.pop(context);},
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    if (categoryTitle != '') {
                      context.read<CategoryListProvider>().addCategory(ItemCategory(title: categoryTitle, items: []));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add'))
            ]),]
    );
  }
}