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

  @override
  Widget build(BuildContext context) {
    ItemCategory itemCategory = widget.itemCategory;
    String categoryTitle = itemCategory.title;
    List<ItemCategory> itemCategoryList = widget.itemCategoryList;

    TextEditingController titleTextEditingController = TextEditingController(
      text: categoryTitle
    );

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: titleTextEditingController,
                  maxLength: 20,
                  autofocus: true,
                ),
              ),
              IconButton(
                  onPressed: () {
                    if (titleTextEditingController.text.isNotEmpty) {
                      print('Sending title ${titleTextEditingController.text}');
                      setState(() =>
                        context
                            .read<PantryProvider>()
                            .editCategoryName(itemCategory, titleTextEditingController.text)
                      );
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.save))
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
