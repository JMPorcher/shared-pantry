import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/providers/app_state_provider.dart';

import '../providers/pantry_provider.dart';

class AddPantryDialog extends StatelessWidget {
  AddPantryDialog({super.key});

  final ValueNotifier<String> pantryTitleValueNotifier = ValueNotifier<String>('');
  final titleTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleTextController.text = pantryTitleValueNotifier.value;
    final PantryProvider pantryProvider = context.watch<PantryProvider>();
    final PageController pageController = context.watch<AppStateProvider>().mainScreenPageController;
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
                AddPantryButton(titleTextController: titleTextController, pantryProvider: pantryProvider, pageController: pageController)
              ]),
        ]);
  }
}

class AddPantryButton extends StatelessWidget {
  const AddPantryButton({
    super.key,
    required this.titleTextController,
    required this.pantryProvider,
    required this.pageController,
  });

  final TextEditingController titleTextController;
  final PantryProvider pantryProvider;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          final String pantryTitle = titleTextController.text;
          if (pantryTitle.isNotEmpty) {
            await pantryProvider.addPantryWithTitle(pantryTitle);
            pantryProvider.switchPantry(pantryProvider.pantriesList.length - 1);
            pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.decelerate);
                //TODO Should add with background image
                //TODO Should add founder name of currentUser ID (FirebaseAuth.instance.currentUser.uid), nullable for anonymous user
                //TODO Should add with generated document ID from firebase
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          }
        },
        child: const Text('Add'));
  }

}

//TODO For Add Pantry dialog: Give option to use assistant with pre-built pantries, categories and items