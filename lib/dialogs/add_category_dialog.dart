import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/pantry.dart';
import '../providers/pantry_provider.dart';

class AddCategoryDialog extends StatelessWidget {
    AddCategoryDialog({ super.key, });

    final ValueNotifier<String> categoryTitleValueNotifier = ValueNotifier<String>('');
    final titleTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleTextController.text = categoryTitleValueNotifier.value;
    final Pantry pantry = context.watch<Pantry>();

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
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    final String categoryTitle = titleTextController.text;
                    if (categoryTitle.isNotEmpty) {
                      //TODO Add category function
                      context.read<PantryProvider>().addCategory(pantry.id, titleTextController.text);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add'))
            ]),]
    );
  }
}