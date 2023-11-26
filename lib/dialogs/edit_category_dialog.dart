import 'package:flutter/material.dart';
import 'package:shared_pantry/dialogs/delete_category_dialog.dart';
import 'package:shared_pantry/models/item_category.dart';
import '../providers/pantry_provider.dart';
import 'package:provider/provider.dart';

class EditCategoryDialog extends StatelessWidget {
  const EditCategoryDialog(
      {required this.itemCategoryList, required this.itemCategory, super.key});

  final ItemCategory itemCategory;
  final List<ItemCategory> itemCategoryList;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> textValueNotifier = ValueNotifier(itemCategory.title);
    final categoryTitleTextController = TextEditingController();
    categoryTitleTextController.text = textValueNotifier.value;
    textValueNotifier.addListener(() => categoryTitleTextController.text = textValueNotifier.value);

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          EditCategoryRow(categoryTitleTextController: categoryTitleTextController, itemCategory: itemCategory),
          const SizedBox(height: 12),
          DeleteCategoryRow(itemCategory: itemCategory, itemCategoryList: itemCategoryList)
        ],
      ),
    );
  }
}

class EditCategoryRow extends StatelessWidget {
  const EditCategoryRow({
    super.key,
    required this.categoryTitleTextController,
    required this.itemCategory,
  });

  final TextEditingController categoryTitleTextController;
  final ItemCategory itemCategory;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: categoryTitleTextController,
            maxLength: 20,
            autofocus: true,
          ),
        ),
        IconButton(
            onPressed: () {
              if (categoryTitleTextController.text.isNotEmpty) {
                  context
                      .read<PantryProvider>()
                      .editCategoryName(itemCategory, categoryTitleTextController.text);

                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.save))
      ],
    );
  }
}

class DeleteCategoryRow extends StatelessWidget {
  const DeleteCategoryRow({
    super.key,
    required this.itemCategory,
    required this.itemCategoryList,
  });

  final ItemCategory itemCategory;
  final List<ItemCategory> itemCategoryList;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
