import 'package:flutter/material.dart';
import 'package:shared_pantry/constants.dart';
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
        PopupMenuButton(
            itemBuilder: (context) {
          return [
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
                child: const ListTile(
                    leading: Text('Shopping List', style: TextStyle(color: Colors.blue)),
                    trailing: Icon(Icons.shopping_cart, color: Colors.blue),
                ),
              ),
            ),
            PopupMenuItem<int>(
              value: 0,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                      EditPantryDialog(pantry: currentPantry,));
                },
                child: ListTile(
                  leading: Text('Edit Pantry', style: kTextStyleAppBarMenu),
                  trailing: const Icon(Icons.edit, color: Colors.blue),
                ),
              ),
            ),
            PopupMenuItem<int>(
              value: 0,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                      AddPantryDialog());
                },
                child: const ListTile(
                  leading: Text('Add new Pantry', style: TextStyle(color: Colors.blue)),
                  trailing: Icon(Icons.add, color: Colors.blue),
                ),
              ),
            ),
          ];
        })
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
