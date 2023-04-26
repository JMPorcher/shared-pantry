import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/models/pantry.dart';

import '../providers/pantry_list_provider.dart';

class AddPantryDialog extends StatefulWidget {
  const AddPantryDialog({super.key});

  @override
  State<AddPantryDialog> createState() => _AddPantryDialogState();
}

class _AddPantryDialogState extends State<AddPantryDialog> {
  String pantryTitle = '';

  @override
  Widget build(BuildContext context) {
    PageController pageController = context.watch<PantryProvider>().pageController;
    List<Pantry> pantryList = context.watch<PantryProvider>().pantriesList;

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
                        context
                            .read<PantryProvider>()
                            .addPantryWithTitle(pantryTitle);

                        Navigator.pop(context);
                        if (pageController.hasClients) {
                          // TODO: animateToPage seems to seek the shortest route to target page? Find out
                          pageController.jumpToPage(pantryList.length-1);
                          // pageController.nextPage(
                          //     duration: const Duration(milliseconds: 1000),
                          //     curve: const ElasticInCurve()
                          // );
                        }
                      }
                    },
                    child: const Text('Add'))
              ]),
        ]);
  }
}
