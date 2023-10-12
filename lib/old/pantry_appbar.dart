import 'package:flutter/material.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/old/shopping_list_dialog.dart';

import '../dialogs/add_pantry_dialog.dart';
import '../dialogs/edit_pantry_dialog.dart';
import '../models/pantry.dart';

class PantryAppBar extends StatelessWidget implements PreferredSizeWidget {

  const PantryAppBar({required this.currentPantry, Key? key}) : super(key: key);

  final Pantry currentPantry;

  @override
  Widget build(BuildContext context) {
    String currentTitle = currentPantry.title;
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kColor5,
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
                      const ShoppingList());
                },
                child: const ListTile(
                    leading: Text('Shopping List', style: TextStyle(color: kColor5)),
                    trailing: Icon(Icons.shopping_cart, color: kColor5),
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
                child: const ListTile(
                  leading: Text('Edit Pantry', style: TextStyle(color: kColor5)),
                  trailing: Icon(Icons.edit, color: kColor5),
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
                  leading: Text('Add new Pantry', style: TextStyle(color: kColor5)),
                  trailing: Icon(Icons.add, color: kColor5),
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
