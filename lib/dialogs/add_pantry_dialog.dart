
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/providers/app_state_provider.dart';
import 'package:shared_pantry/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/pantry_provider.dart';
import '../screens/first_startup_screen.dart';

class AddPantryDialog extends StatelessWidget {
  AddPantryDialog({super.key});

  final ValueNotifier<String> pantryTitleValueNotifier = ValueNotifier<String>('');
  final titleTextController = TextEditingController();
  final SpAuthProvider authProvider = SpAuthProvider();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      final User? currentUser = await authProvider.getCurrentUser();
                       if (currentUser == null) {
                         navigator.popAndPushNamed(FirstStartupScreen.id);
                       } else {
                         await pantryProvider.addPantryWithTitle(titleTextController.text);
                         navigator.pop();
                       }
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

            if (context.mounted) {
              Navigator.of(context).pop();
            }
          }
        },
        child: const Text('Add'));
  }

}
