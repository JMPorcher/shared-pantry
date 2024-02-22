

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/providers/app_state_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_pantry/services/database_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPantryDialog extends StatelessWidget {
  AddPantryDialog({super.key});
  final ValueNotifier<String> pantryTitleValueNotifier = ValueNotifier<String>('');
  final titleTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    titleTextController.text = pantryTitleValueNotifier.value;
    final AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);

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
                AddPantryButton(titleTextController: titleTextController, pageController: appStateProvider.mainScreenPageController)
              ]),
        ]);
  }
}

class AddPantryButton extends StatelessWidget {
  const AddPantryButton({
    super.key,
    required this.titleTextController,
    required this.pageController,
  });

  final TextEditingController titleTextController;
  final PageController pageController;


  @override
  Widget build(BuildContext context) {
    final User? user = context.watch<User?>();

    return TextButton(
        onPressed: () async {
          final String pantryTitle = titleTextController.text;
          if (pantryTitle.isNotEmpty) {
            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            DocumentReference pantryReference = await DatabaseService().addPantryWithTitle(pantryTitle, user?.uid);
            sharedPreferences.setString('Last shown pantry', pantryReference.id);

            if (context.mounted) {
              Navigator.of(context).pop();
            }
            pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.decelerate);
          }
        },
        child: const Text('Add'));
  }
}
