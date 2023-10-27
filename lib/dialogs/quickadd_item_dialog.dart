import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/providers/pantry_provider.dart';

import '../models/item.dart';

class QuickaddItemDialog extends StatelessWidget {
  QuickaddItemDialog(this.quickaddedItems, this.title, this.filterItems, {super.key});

  final Function filterItems;
  final List<Item> quickaddedItems;
  final String title;
  final ValueNotifier<String> categoryTitleValueNotifier =
      ValueNotifier<String>('');
  final titleTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleTextController.text = categoryTitleValueNotifier.value;
    final pantryList = context.watch<PantryProvider>().pantriesList;

    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
              content: Column(
                children: [
                  TextButton(
                      onPressed: () {}, child: const Text('Save to a pantry')),
                  //TODO find a design for pantry and category chooser
                  const SizedBox(width: 16),
                  TextButton(
                      onPressed: () {
                        quickaddedItems.add(Item(title));
                        filterItems(pantryList);
                        Navigator.pop(context);
                      },
                      child: const Text('Just to shopping list')),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'))
              ]),
        ]);
  }
}
//TODO Make a new provider for quickadd function