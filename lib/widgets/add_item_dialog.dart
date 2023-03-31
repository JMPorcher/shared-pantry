import 'package:flutter/material.dart';
import 'package:shared_pantry/constants.dart';
import '../models/item_category.dart';
import '../providers/item_list_provider.dart';
import 'package:provider/provider.dart';

class AddDialog extends StatefulWidget {
  AddDialog({required this.categoryIndex, super.key});

  int categoryIndex;

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  bool itemInStock = false;
  String categoryTitle = '';

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
                    categoryTitle = newString;
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
                  context.read<ItemListProvider>().addCategory(kTestCategory);
                  Provider.of<ItemListProvider>(context,listen: false).printCategories();
                  Navigator.pop(context);
                },
                child: const Text('Add'))
          ]),]
    );
  }
}
