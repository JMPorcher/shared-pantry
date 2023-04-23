import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pantry_list_provider.dart';

class AddPantryDialog extends StatefulWidget {
  const AddPantryDialog({required this.pageController, super.key});

  final PageController pageController;

  @override
  State<AddPantryDialog> createState() => _AddPantryDialogState();
}

class _AddPantryDialogState extends State<AddPantryDialog> {
  String pantryTitle = '';

  @override
  Widget build(BuildContext context) {
    PantryProvider pantryProvider = context.watch<PantryProvider>();
    PageController pageController = widget.pageController;

    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
              title: const Text('Add another pantry:'),
              content: TextField(
                autofocus: true,
                onChanged: (newString) {
                  setState(() {
                    pantryTitle = newString;
                  });
                },
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      if (pantryTitle != '') {
                        pantryProvider.addPantryWithTitle(pantryTitle);
                        //TODO Jump to new page
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add'))
              ]),
        ]);
  }
}
