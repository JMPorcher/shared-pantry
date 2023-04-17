import 'package:flutter/material.dart';
import '../models/item.dart';
import '../providers/category_list_provider.dart';
import 'package:provider/provider.dart';

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({required this.categoryIndex, super.key});

  final int categoryIndex;

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  bool itemInStock = false;
  String itemTitle = '';
  late int categoryIndex;

  @override
  void initState() {
    super.initState();
    categoryIndex = widget.categoryIndex;
  }

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
                    context.read<CategoryListProvider>().addItem(categoryIndex, Item(itemTitle, itemInStock));
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add'))
          ]),]
    );
  }
}
