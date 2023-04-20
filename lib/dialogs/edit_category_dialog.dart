import 'package:flutter/material.dart';
import 'package:shared_pantry/models/item_category.dart';
import '../providers/pantry_list_provider.dart';
import 'package:provider/provider.dart';

class EditCategoryDialog extends StatefulWidget {
  const EditCategoryDialog({required this.itemCategory, super.key});

  final ItemCategory itemCategory;

  @override
  State<EditCategoryDialog> createState() => _EditCategoryDialogState();
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  bool itemInStock = false;
  String newTitle = '';

  @override
  Widget build(BuildContext context) {
    ItemCategory itemCategory = widget.itemCategory;
    String categoryTitle = itemCategory.title;

    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [AlertDialog(
            title: const Text('Edit category name:'),
            content: Column(
              children: [
                TextFormField(
                  initialValue: categoryTitle,
                  autofocus: true,
                  onChanged: (newString) {
                    setState(() {
                      newTitle = newString;
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {Navigator.pop(context);},
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    if (newTitle.isNotEmpty) {
                      context.read<PantryListProvider>().editCategory(itemCategory, newTitle);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save change'))
            ]),]
    );
  }
}
