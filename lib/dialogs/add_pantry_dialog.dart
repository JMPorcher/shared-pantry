import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loop_page_view/loop_page_view.dart';
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
    LoopPageController pageController = context.watch<PantryProvider>().pageController;
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
                        Timer(const Duration(milliseconds: 0), () {
                        if (pageController.hasClients) {
                          // TODO: Make animation to new page less wonky?
                          pageController.animateJumpToPage(
                            pantryList.length-1,
                            duration: const Duration(milliseconds: 1000),
                            curve: const ElasticInCurve(),
                          );
                        }
                        });
                      }
                    },
                    child: const Text('Add'))
              ]),
        ]);
  }
}
