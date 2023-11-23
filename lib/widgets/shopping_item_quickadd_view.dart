import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_pantry/dialogs/quickadd_item_dialog.dart';
import 'package:shared_pantry/widgets/text_input_fields.dart';

import '../models/item.dart';
import 'buttons.dart';

class ShoppingItemQuickAdd extends StatefulWidget {

  const ShoppingItemQuickAdd(this.quickaddedItems, this.filterItems, this.backgroundColor, {super.key});

  final Function filterItems;
  final List<Item> quickaddedItems;
  final Color backgroundColor;

  @override
  State<ShoppingItemQuickAdd> createState() => _ShoppingItemQuickAddState();
}

class _ShoppingItemQuickAddState extends State<ShoppingItemQuickAdd> {
  final ValueNotifier<String> itemTitleValueNotifier =
      ValueNotifier<String>('');

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = widget.backgroundColor;

    void showItemQuickAddDialog() => showDialog(
        context: context, builder: (BuildContext context) => QuickaddItemDialog(widget.quickaddedItems, textEditingController.text, widget.filterItems));
    textEditingController.text = itemTitleValueNotifier.value;

    ValueNotifier<bool> fieldIsEmpty = ValueNotifier(true);

    return SizedBox(
      height: 40,
      child: ListTile(
        tileColor: backgroundColor,
        dense: true,
        leading: ItemTitleInputLine(
            textEditingController: textEditingController,
            fieldIsEmpty: fieldIsEmpty),
        trailing: AddItemButton(
          fieldIsEmpty: fieldIsEmpty, onPressed: showItemQuickAddDialog,),
      ),
    );
  }
}


