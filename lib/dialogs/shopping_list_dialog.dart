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
  //The
  //Shown items have to come from and point directly to the provider


  Map<String, bool> pantrySwitchMap = <String, bool>{};
  List<Pantry> pantries = [];
  List<Item> itemsThatRanOut = [];
  late List<String> pantryTitles;
  Map<String, bool> relevantItemsMap = <String, bool>{};
  List<Item> changedItems = [];

  @override
  void dispose() {
    super.dispose();
    for (Item item in changedItems) {
      context.read<PantryProvider>().toggleItemAvailability(item);
    }
  }

  void filterItems() {
    itemsThatRanOut.clear();

    //Get all the KEY/VALUE-PAIRS of Pantries that are not selected
    final Map<String, bool> selectedPantriesMap = Map.from(pantrySwitchMap)
      ..removeWhere((key, value) => value == false);

    //Get a list of the actual PANTRIES that are selected
    final List<Pantry> selectedPantries = [];
    for (var pantry in pantries) {
      if (selectedPantriesMap.containsKey(pantry.pantryTitle)) {
        selectedPantries.add(pantry);
      }
    }

    //Add items from the selected Pantries to the list of items that ran out
    for (Pantry pantry in selectedPantries) {
      for (ItemCategory category in pantry.categoryList) {
        itemsThatRanOut.addAll(
            category.items.where((i) => i.isAvailable == false).toList());
      }
    }
    for (var item in itemsThatRanOut) {
      //relevantItemsMap.clear();
      relevantItemsMap.putIfAbsent(item.title, () => false); }
    print('Relevant items map: $relevantItemsMap - items: ${relevantItemsMap.length}');
  }



  @override
  Widget build(BuildContext context) {
    if (pantries.isEmpty) {
      pantries.addAll(context.watch<PantryProvider>().pantriesList);
      for (var pantry in pantries) {
        pantrySwitchMap[pantry.pantryTitle] = true;
      }
      pantryTitles = pantrySwitchMap.keys.toList();
    }
    filterItems();

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
                            trailing: Switch(
                              value: pantrySwitchMap[pantryTitles[index]] ?? true,
                              onChanged: (bool newValue) {
                                setState(() {
                                  pantrySwitchMap[pantryTitles[index]] =
                                      newValue;
                                  filterItems();
                                });
                              },
                            ));
                      }),
                ), //Pantry selection
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Divider(thickness: 2),
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: itemsThatRanOut.length * 56,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: itemsThatRanOut.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            leading: Text(itemsThatRanOut[index].title),
                            trailing: Checkbox(
                              value: false,
                              onChanged: (bool? value) {  },),
                        );
                        //TODO Display filtered items as checklist instead of text list
                      }),
                ),
                TextButton(
                    onPressed: () async {
                      String itemsThatRanOutString = '';
                      for (Item item in itemsThatRanOut) {
                        itemsThatRanOutString += '${item.title}\n';
                      }
                      if (itemsThatRanOutString.isNotEmpty) {
                        await Clipboard.setData(
                            ClipboardData(text: itemsThatRanOutString));
                        Fluttertoast.showToast(
                            msg: "Successfully copied to clipboard",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.black,
                            fontSize: 16.0);
                      } else {
                        Fluttertoast.showToast(
                            msg: "No items to copy",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.black,
                            fontSize: 16.0);
                      }
                    },
                    child: const Text('Copy to clipboard')),//Copy list as text button
              ],
            ),
          ),
        )
    );
  }
}
