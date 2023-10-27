import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_pantry/dialogs/quickadd_item_dialog.dart';

import '../constants.dart';
import '../models/item.dart';

class ShoppingItemQuickAdd extends StatelessWidget {

  ShoppingItemQuickAdd(this.quickaddedItems, this.filterItems, {super.key});

  final Function filterItems;
  final List<Item> quickaddedItems;
  final ValueNotifier<String> itemTitleValueNotifier =
      ValueNotifier<String>('');
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void showItemQuickAddDialog() => showDialog(
        context: context, builder: (BuildContext context) => QuickaddItemDialog(quickaddedItems, textEditingController.text, filterItems));
    textEditingController.text = itemTitleValueNotifier.value;
    return ListTile(
      leading: SizedBox(
        width: 230,
        child: TextField(
          inputFormatters: [LengthLimitingTextInputFormatter(90)],
          controller: textEditingController,
        ),
      ),
      trailing: SizedBox(
        width: 40,
        child: ElevatedButton(
            style:
                ButtonStyle(backgroundColor: MaterialStateProperty.all(kColor51), padding: MaterialStateProperty.all(const EdgeInsets.all(0))),
            onPressed: () => showItemQuickAddDialog(),
            child: const Icon(
              Icons.add,
              color: kColor11,
            )),
      ),
    );
  }
}
