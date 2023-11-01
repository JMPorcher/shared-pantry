import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_pantry/models/item_category.dart';
import '../models/item.dart';
import '../providers/pantry_provider.dart';
import 'package:provider/provider.dart';

class AddItemDialog extends StatelessWidget {
  const AddItemDialog({required this.currentCategory, super.key});

  final ItemCategory currentCategory;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String> itemTitleValueNotifier = ValueNotifier<String>('');
    final titleTextController = TextEditingController();
    titleTextController.text = itemTitleValueNotifier.value;
    final ValueNotifier<bool> isInStock = ValueNotifier(false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [AlertDialog(
          title: const Text('Add item to your pantry:'),
          content: Column(
            children: [
              TextField(
                controller: titleTextController,
                inputFormatters: [LengthLimitingTextInputFormatter(90)],
                autofocus: true,
              ),
              Row(
                //mainAxisSize: MainAxisSize.min,
                children: [
                  ValueListenableBuilder(
                    valueListenable: isInStock,
                    builder: (_, bool value, Widget? child) {
                      return Checkbox(
                          value: isInStock.value,
                          onChanged: (newValue) {
                            if (newValue != null) {
                              isInStock.value = newValue;
                            }
                          });
                    },
                  ),
                  const Text('Item is in stock')
                ],
              )// In stock bool row
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {Navigator.pop(context);},
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  final String itemTitle = titleTextController.text;
                  if (itemTitle != '') {
                    context.read<PantryProvider>().addItem(currentCategory, Item(itemTitle, isAvailable: isInStock.value));
                    Navigator.pop(context);
                    //TODO Limit item title to 90
                  }
                },
                child: const Text('Add'))
          ]),]
    );
  }
}
