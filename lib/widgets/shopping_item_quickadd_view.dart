import 'package:flutter/material.dart';

import '../constants.dart';
import '../dialogs/add_pantry_dialog.dart';

class ShoppingItemQuickAdd extends StatelessWidget {
  ShoppingItemQuickAdd({super.key});

  final ValueNotifier<String> itemTitleValueNotifier = ValueNotifier<String>('');
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    void showItemQuickAddDialog() => showDialog(
        context: context, builder: (BuildContext context) => AddPantryDialog());
    textEditingController.text = itemTitleValueNotifier.value;
    return ListTile(
      leading: TextField(
        controller: textEditingController,
      ),
      trailing: GestureDetector(
        onTap: () => showItemQuickAddDialog(),
        child: const Icon(Icons.add, color: kColor5,),
      ),
    );
  }
}
