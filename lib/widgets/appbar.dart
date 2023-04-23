import 'package:flutter/material.dart';
import 'package:shared_pantry/dialogs/shopping_list_dialog.dart';

import '../dialogs/add_pantry_dialog.dart';
import '../dialogs/edit_pantry_dialog.dart';
import '../models/pantry.dart';

class PantryAppBar extends StatelessWidget implements PreferredSizeWidget {

  const PantryAppBar({required this.currentPantry, required this.pageController, Key? key}) : super(key: key);

  final Pantry currentPantry;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    String currentTitle = currentPantry.pantryTitle;
    return AppBar(
      title: Text(currentTitle),
      actions: <Widget>[
        IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                  EditPantryDialog(pantry: currentPantry));
            }
        ),
        PopupMenuButton(

            itemBuilder: (context) {
          return [
            PopupMenuItem<int>(
              value: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                      AddPantryDialog(pageController: pageController,));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text('Add new Pantry', style: TextStyle(color: Colors.blue)),
                    Icon(Icons.add, color: Colors.blue)
                  ],
                ),
              ),
            ),
            PopupMenuItem<int>(
              value: 1,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                      const ShoppingListDialog());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text('Shopping List', style: TextStyle(color: Colors.blue)),
                    Icon(Icons.shopping_cart, color: Colors.blue),
                  ],
                ),
              ),
            )
          ];
        })
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
