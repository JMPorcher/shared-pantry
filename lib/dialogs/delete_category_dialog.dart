import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/models/item_category.dart';
import '../providers/pantry_list_provider.dart';

class DeleteCategoryDialog extends StatefulWidget {
  const DeleteCategoryDialog(
      {required this.currentCategory, super.key});

  final ItemCategory currentCategory;

  @override
  State<DeleteCategoryDialog> createState() => _DeleteCategoryDialogState();
}


class _DeleteCategoryDialogState extends State<DeleteCategoryDialog> {

  @override
  Widget build(BuildContext context) {
    ItemCategory currentCategory = widget.currentCategory;

    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
              title: const SizedBox(
                width: double.infinity,
                child: Text('You are about to delete category'),
              ),
              content: Text(currentCategory.title, textAlign: TextAlign.center),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      context
                          .read<PantryListProvider>()
                          .removeCategoryAt(categoryIndex);
                    },
                    child: const Text('Yes'))
              ]),
        ]);
  }
}
