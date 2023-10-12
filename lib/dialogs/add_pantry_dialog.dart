import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pantry_provider.dart';

class AddPantryDialog extends StatelessWidget {
  AddPantryDialog({super.key});

  final ValueNotifier<String> pantryTitleValueNotifier = ValueNotifier<String>('');
  final titleTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleTextController.text = pantryTitleValueNotifier.value;
    //TODO Background image picker
    //

    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
              title: const Text('Add new pantry:'),
              content: TextField(
                controller: titleTextController,
                autofocus: true,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      final String pantryTitle = titleTextController.text;
                      if (pantryTitle != '') {
                        context
                            .read<PantryProvider>()
                            .addPantryWithTitle(pantryTitle);
                            //TODO Should add with background image
                            //TODO Should add with user name of founder ID, get ID from FirebaseAuth.instance.currentUser.uid
                            //TODO Should add with generated unique ID
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add'))
              ]),
        ]);
  }
}
