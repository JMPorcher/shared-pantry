import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_pantry/dialogs/quickadd_item_dialog.dart';

import '../constants.dart';
import '../models/item.dart';

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

    return ListTile(
      tileColor: backgroundColor,
      leading: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: SizedBox(
          width: 40,
          child: ValueListenableBuilder(
            valueListenable: fieldIsEmpty,
            builder: (BuildContext context, bool value, Widget? child) {
              return ElevatedButton(
                  style:
                  ButtonStyle(
                      backgroundColor: fieldIsEmpty.value ? MaterialStateProperty.all(kColor51.withOpacity(0.4)) : MaterialStateProperty.all(kColor51),
                      padding: MaterialStateProperty.all(const EdgeInsets.all(0))
                  ),
                  onPressed: () => showItemQuickAddDialog(),
                  child: const Icon(
                    Icons.add,
                    color: kColor1,
                  ));
            },

          ),
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 240,
            height: 24,
            child: QuickAddTextField(textEditingController: textEditingController, fieldIsEmpty: fieldIsEmpty),
          ),
        ],
      ),
    );
  }
}

class QuickAddTextField extends StatelessWidget {
  const QuickAddTextField({
    super.key,
    required this.textEditingController,
    required this.fieldIsEmpty,
  });

  final TextEditingController textEditingController;
  final ValueNotifier<bool> fieldIsEmpty;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (_) {
        if (textEditingController.text.isNotEmpty) {
          fieldIsEmpty.value = false;
        } else {
          fieldIsEmpty.value = true;
        }
      },
      style: const TextStyle(fontSize: 14),
      textAlign: TextAlign.center,
      inputFormatters: [LengthLimitingTextInputFormatter(90)],
      controller: textEditingController,
      decoration: const InputDecoration(
        hintText: '(Add item)',
        hintStyle: TextStyle(color: Colors.black26, fontSize: 14),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12, width: 3)
        )
      ),
    );
  }
}
