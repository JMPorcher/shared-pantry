import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/item.dart';
import '../models/item_category.dart';
import '../models/pantry.dart';
import '../providers/pantry_list_provider.dart';

class ShoppingListDialog extends StatefulWidget {
  const ShoppingListDialog({super.key});

  @override
  State<ShoppingListDialog> createState() => _ShoppingListDialogState();
}

class _ShoppingListDialogState extends State<ShoppingListDialog> {
  //CHECK Load pantriesList from provider.
  //CHECK Show the pantries list with switches. Flipping the switches will toggle the selected property of each pantry.
  //From the start and upon each flicking of a switch the item list below will be filtered.
  //The item filter will iterate over the pantries and their item lists and draw all unavailable items directly from the Provider.
  //Checking a box will directly toggle the corresponding item in the provider.

  List<Item> relevantItems = [];

  void filterItems(List<Pantry> pantryList) {
    relevantItems.clear();
    for (Pantry pantry in pantryList) {
      if (pantry.selected) {
        for (ItemCategory category in pantry.categoryList) {
          for (Item item in category.items) {
            if (!item.isAvailable) {
              relevantItems.add(item);
            }
          }
        }
      }
    }
  }

  void addAllItems(List<Pantry> pantryList) {
    for (Pantry pantry in pantryList) {
      for (ItemCategory category in pantry.categoryList) {
        for (Item item in category.items) {
          if (!item.isAvailable) {
            relevantItems.add(item);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Pantry> pantryList = context.watch<PantryProvider>().pantriesList;
    filterItems(pantryList);

    return AlertDialog(
        title: const Text('Shopping list'),
        content: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: pantryList.length * 40 + 20,
              child: ListView.builder(
                  itemCount: pantryList.length,
                  itemExtent: 40,
                  itemBuilder: (_, index) {
                    Pantry currentPantry = pantryList[index];
                    return ListTile(
                      leading: Text(currentPantry.pantryTitle),
                      trailing: Switch(
                        value: currentPantry.selected,
                        onChanged: (_) {
                          setState(() {
                            currentPantry.selected = !currentPantry.selected;
                            filterItems(pantryList);
                          });
                        },
                      ),
                    );
                  }),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Divider(thickness: 2),
            ),
            SizedBox(
                width: double.maxFinite,
                height: relevantItems.length * 60 <= 400 ? 400 : relevantItems.length * 60,
                child: ListView.builder(
                  itemCount: relevantItems.length,
                  itemBuilder: (_, index) {
                    Item currentItem = relevantItems[index];
                    return ListTile(
                      visualDensity: const VisualDensity(vertical: -4),
                      leading: Text(currentItem.title),
                      trailing: Checkbox(
                        value: currentItem.isAvailable,
                        onChanged: (bool? value) {
                          setState(() {
                            context.read<PantryProvider>().toggleItemAvailability(currentItem);
                          });
                        },
                      ),
                    );
                  },
                ))
          ],
        )));
  }
}
