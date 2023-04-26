import 'package:flutter/material.dart';
import 'package:shared_pantry/dialogs/shopping_list_dialog.dart';

import '../dialogs/add_pantry_dialog.dart';
import '../dialogs/edit_pantry_dialog.dart';
import '../models/pantry.dart';

class PantryAppBar extends StatelessWidget implements PreferredSizeWidget {

  const PantryAppBar({required this.currentPantry, Key? key}) : super(key: key);

  final Pantry currentPantry;

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
            //TODO Add pantry doesn't seem to work when freshly installed
            PopupMenuItem<int>(
              value: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                      const AddPantryDialog());
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
