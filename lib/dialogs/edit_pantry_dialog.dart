import 'package:flutter/material.dart';
import '../models/pantry.dart';
import '../providers/pantry_list_provider.dart';
import 'package:provider/provider.dart';

class EditPantryDialog extends StatefulWidget {
  const EditPantryDialog({required this.pantry, super.key});

  final Pantry pantry;

  @override
  State<EditPantryDialog> createState() => _EditPantryDialogState();
}

class _EditPantryDialogState extends State<EditPantryDialog> {
  bool itemInStock = false;
  String newTitle = '';

  @override
  Widget build(BuildContext context) {
    Pantry pantry = widget.pantry;
    String pantryTitle = pantry.pantryTitle;

    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [AlertDialog(
            title: const Text('Edit Pantry name:'),
            content: Column(
              children: [
                TextFormField(
                  initialValue: pantryTitle,
                  autofocus: true,
                  onChanged: (newString) {
                    setState(() {
                      newTitle = newString;
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {Navigator.pop(context);},
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    if (newTitle.isNotEmpty) {
                      context.read<PantryProvider>().editPantry(pantry, newTitle);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save change'))
            ]),]
    );
  }
}