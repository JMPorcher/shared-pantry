import 'package:flutter/material.dart';
import 'package:shared_pantry/models/item_category.dart';
import '../models/item.dart';
import '../providers/pantry_list_provider.dart';
import 'package:provider/provider.dart';

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({required this.currentItemList, super.key});

  final List<Item> currentItemList;

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  bool itemInStock = false;
  String itemTitle = '';

  @override
  Widget build(BuildContext context) {
    List<Item> currentItemList = widget.currentItemList;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [AlertDialog(
          title: const Text('Add item to your pantry:'),
          content: Column(
            children: [
              TextField(
                autofocus: true,
                onChanged: (newString) {
                  setState(() {
                    itemTitle = newString;
                  });
                },
              ),
              Row(
                children: [
                  Checkbox(
                      value: itemInStock,
                      onChanged: (value) {
                        setState(() {
                          itemInStock = value!;
                        });
                      }),
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
                  if (itemTitle != '') {
                    context.read<PantryListProvider>().addItem(currentItemList, Item(itemTitle, itemInStock));
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add'))
          ]),]
    );
  }
}
