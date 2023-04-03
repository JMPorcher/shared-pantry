import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_pantry/models/item_category.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/item.dart';
import '../providers/item_list_provider.dart';

class ShoppingListDialog extends StatefulWidget {
  const ShoppingListDialog({super.key});

  @override
  State<ShoppingListDialog> createState() => _ShoppingListDialogState();
}

class _ShoppingListDialogState extends State<ShoppingListDialog> {

 @override
  Widget build(BuildContext context) {
    //TODO Change allItems to gather all items from all categories
    var providerList = context.watch<ItemListProvider>().categoriesList;
    List<Item> itemsThatRanOut = [];
    for (ItemCategory category in providerList) {
      itemsThatRanOut.addAll(category.items.where((i) => i.isAvailable == false).toList());
    }
  // Testing

    String appendUnavailableItems() {
      String unavailableItems = '';
      for (Item item in itemsThatRanOut) {
        unavailableItems += "${item.title}\n";
      }
      return unavailableItems;
    }
    String shoppingList = appendUnavailableItems();

    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
              title: const Text('Shopping list'),
              content: Column(
                children: [
                  TextButton(
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(text: shoppingList));
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
                  SelectableText(shoppingList)
                ],
              ),
              actions: [
                TextButton(
                    onPressed: Navigator.of(context).pop,
                    child: const Text('Cancel')),
              ])
        ]);
  }
}
