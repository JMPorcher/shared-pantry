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
    final PantryProvider pantryProvider = context.watch<PantryProvider>();
    final PageController pageController = context.watch<PantryProvider>().mainScreenPageController;

    //TODO Background image picker

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
                        pantryProvider.addPantryWithTitle(pantryTitle);
                        pantryProvider.switchPantry(pantryProvider.pantriesList.length-1);
                        pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.decelerate);
                            //TODO Should add with background image
                            //TODO Should add founder name of currentUser ID, get ID from FirebaseAuth.instance.currentUser.uid
                            //TODO Should add with generated document ID from firebase
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add'))
              ]),
        ]);
  }
}

//TODO For Add Pantry dialog: Give option to use assistant with pre-built pantries, categories and items