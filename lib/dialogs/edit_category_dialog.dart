import 'package:flutter/material.dart';
import '../providers/category_list_provider.dart';
import 'package:provider/provider.dart';

class EditCategoryDialog extends StatefulWidget {
  const EditCategoryDialog({required this.categoryIndex, super.key});

  final int categoryIndex;

  @override
  State<EditCategoryDialog> createState() => _EditCategoryDialogState();
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  bool itemInStock = false;
  String newTitle = '';

  @override
  Widget build(BuildContext context) {
    int categoryIndex = widget.categoryIndex;
    String categoryTitle = context.watch<CategoryListProvider>().categoriesList[categoryIndex].title;

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
                      context.read<CategoryListProvider>().editCategory(categoryIndex, newTitle);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save change'))
            ]),]
    );
  }
}
