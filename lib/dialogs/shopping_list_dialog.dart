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
//TODO Clicking a checkbox probably makes the build method re-run and resets the pantryCheckboxMap, making it impossible to uncheck a pantry
  Map<String, bool?> pantryCheckboxMap = <String, bool>{};
  List<Pantry> pantries = [];
  late List<String> pantryTitles;

  @override
  Widget build(BuildContext context) {

    if (pantries.isEmpty) {
      pantries.addAll(context.watch<PantryProvider>().pantriesList);
      for (var pantry in pantries) {
        pantryCheckboxMap[pantry.pantryTitle] = true;
      }
      pantryTitles = pantryCheckboxMap.keys.toList();
    }


    List<Item> itemsThatRanOut = [];
   //
   // void filterItems() {
   //   Map<String, bool> selectedPantries = Map.from(pantryCheckboxMap).removeWhere((key, value) => value == false);
   //    //TODO Find a way to iterate through the selectedPantries map
   //  selectedPantries.
   //   {
   //    for(ItemCategory category in pantry.categoryList) {
   //      itemsThatRanOut.addAll(category.items.where((i) => i.isAvailable == false).toList());
   //    }
   //  }
   //
   //
   // }

    return AlertDialog(
        title: const Text('Shopping list'),
        content: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: double.maxFinite,
            child: Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  height: pantryTitles.length * 40 + 20,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: pantryTitles.length,
                      itemExtent: 40,
                      itemBuilder: (context, index) {
                        return ListTile(
                            leading: Text(pantryTitles[index]),
                            trailing: Checkbox(
                              value: pantryCheckboxMap[pantryTitles[index]],
                              onChanged: (bool? newValue) {
                                setState(() {
                                  pantryCheckboxMap[pantryTitles[index]] = newValue;
                                });
                              },
                            ));
                      }
                  ),
                ),//Pantry selection
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Divider(thickness: 2),
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: itemsThatRanOut.length * 20,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: itemsThatRanOut.length,
                    itemBuilder: (context, index) {
                      return Text(itemsThatRanOut[index].title);
                    }),
                ),
                TextButton(
                    onPressed: () async {
                      await Clipboard.setData(const ClipboardData(text: 'lol'));
                      Fluttertoast.showToast(
                          msg: "Successfully copied to clipboard",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.black,
                          fontSize: 16.0);
                    },
                    child: const Text('Copy to clipboard')),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancel')),
        ]);
  }
}
