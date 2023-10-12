import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/item.dart';
import '../models/item_category.dart';
import '../models/pantry.dart';
import '../providers/pantry_provider.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  List<Item> relevantItems = [];

  void filterItems(List<Pantry> pantryList) {
    relevantItems.clear();
    for (Pantry pantry in pantryList) {
      if (pantry.selectedForShopping) {
        for (ItemCategory category in pantry.categories) {
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
      for (ItemCategory category in pantry.categories) {
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

    return SingleChildScrollView(
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
                  leading: Text(currentPantry.title),
                  trailing: Switch(
                      value: currentPantry.selectedForShopping,
                      onChanged: (newValue) {
                        context.read<PantryProvider>().switchPantrySelectedForShopping(currentPantry, newValue);
                      }),
                );
              }),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Divider(thickness: 2),
        ),
        SizedBox(
            width: double.maxFinite,
            height: relevantItems.length * 60 <= 400
                ? 400
                : relevantItems.length * 60,
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
                        context
                            .read<PantryProvider>()
                            .toggleItemAvailability(currentItem);
                      });
                    },
                  ),
                );
              },
            ))
      ],
    ));
  }
}
