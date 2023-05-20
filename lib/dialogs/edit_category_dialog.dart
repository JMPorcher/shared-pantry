import 'package:flutter/material.dart';
import 'package:shared_pantry/dialogs/delete_category_dialog.dart';
import 'package:shared_pantry/models/item_category.dart';
import '../providers/pantry_list_provider.dart';
import 'package:provider/provider.dart';

class EditCategoryDialog extends StatefulWidget {
  const EditCategoryDialog(
      {required this.itemCategoryList, required this.itemCategory, super.key});

  final ItemCategory itemCategory;
  final List<ItemCategory> itemCategoryList;

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
    List<ItemCategory> itemCategoryList = widget.itemCategoryList;
    newTitle = categoryTitle;

    return AlertDialog(
      content: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  maxLength: 20,
                  initialValue: categoryTitle,
                  autofocus: true,
                  onChanged: (newString) {
                    setState(() {
                      newTitle = newString;
                    });
                  },
                ),
              ),
              IconButton(
                  onPressed: () {
                    if (newTitle.isNotEmpty) {
                      context
                          .read<PantryProvider>()
                          .editCategory(itemCategory, newTitle);
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.save))
            ],
          ),
          Row(
            children: [
              const Text('Delete Category'),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (context) => DeleteCategoryDialog(
                          currentCategory: itemCategory,
                          currentCategoryList: itemCategoryList));
                },
                icon: const Icon(Icons.delete),
              )
            ],
          )
        ],
      ),
    );
  }
}
