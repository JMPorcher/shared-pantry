import 'package:flutter/material.dart';
import 'item_list.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';

class AddDialog extends StatefulWidget {
  const AddDialog({super.key});

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  bool itemInStock = false;
  String itemTitle = '';

  @override
  Widget build(BuildContext context) {
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
              )
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {Navigator.pop(context);},
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  context.read<ItemListProvider>().addItem(Item(itemTitle, itemInStock));
                  Navigator.pop(context);
                },
                child: const Text('Add'))
          ]),]
    );
  }
}
