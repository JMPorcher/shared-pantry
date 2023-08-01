import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/models/pantry.dart';

import '../providers/pantry_list_provider.dart';

class AddPantryDialog extends StatelessWidget {
  AddPantryDialog({super.key});

  final ValueNotifier<String> pantryTitleValueNotifier = ValueNotifier<String>('');
  final titleTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    LoopPageController pageController = context.watch<PantryProvider>().pageController;
    List<Pantry> pantryList = context.watch<PantryProvider>().pantriesList;
    titleTextController.text = pantryTitleValueNotifier.value;

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

                        Navigator.pop(context);
                        Timer(const Duration(milliseconds: 0), () {
                          // TODO: Change to animateToPage() but make animation to new page less wonky?
                          pageController.jumpToPage(
                            pantryList.length-1,
                          );
                        });
                      }
                    },
                    child: const Text('Add'))
              ]),
        ]);
  }
}
