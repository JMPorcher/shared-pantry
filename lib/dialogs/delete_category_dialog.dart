import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/models/item_category.dart';
import 'package:shared_pantry/providers/pantry_list_provider.dart';

class DeleteCategoryDialog extends StatelessWidget {
  const DeleteCategoryDialog(
      {required this.currentCategory,
       required this.currentCategoryList,
       super.key});

  final ItemCategory currentCategory;
  final List<ItemCategory> currentCategoryList;

  @override
  Widget build(BuildContext context) {

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
                      context.read<PantryProvider>().removeCategory(currentCategoryList, currentCategory);
                    },
                    child: const Text('Yes'))
              ]),
        ]);
  }
}
