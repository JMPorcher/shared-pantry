import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_pantry/models/item_category.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/item.dart';
import '../models/pantry.dart';
import '../providers/pantry_list_provider.dart';

class ShoppingListDialog extends StatefulWidget {
  const ShoppingListDialog({super.key});

  @override
  State<ShoppingListDialog> createState() => _ShoppingListDialogState();
}

class _ShoppingListDialogState extends State<ShoppingListDialog> {
  //Load pantriesList from provider.
  //Show the pantries list with switches. Flipping the switches will toggle the selected property of each pantry.
  //From the start and upon each flicking of a switch the item list below will be filtered.
  //The item filter will iterate over the pantries and their item lists and draw all unavailable items directly from the Provider.
  //Checking a box will directly toggle the corresponding item in the provider.



  void filterItems() {
//TODO Filter items function
  }



  @override
  Widget build(BuildContext context) {
    List<Pantry> pantryList = context.watch<PantryProvider>().pantriesList;
    filterItems();

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
                    //itemExtent: ,
                    itemBuilder: (_, index) {
                  Pantry currentPantry = pantryList[index];
                  return ListTile(
                      leading: Text(currentPantry.pantryTitle),
                      trailing: Switch(
                        value: currentPantry.selected,
                        onChanged: (_) {
                            setState(() {
                              currentPantry.selected = !currentPantry.selected;
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
                height: pantryList.length * 60,
                child: ListView.builder(
                  //TODO Feed in actual filtered items
                  itemCount: 1,
                  itemBuilder: (_, index) {
                    Item currentItem = Item('lol', true);
                    return ListTile(
                      leading: Text(currentItem.title),
                      trailing: Checkbox(
                        value: currentItem.isAvailable,
                        onChanged: (bool? value) {
                          setState(() {
                            //context.read<PantryProvider>().toggleItemAvailability(currentItem);
                          });
                        },),
                    );
                  },
                )
              )
            ],
           )
        )
    );
  }
}
