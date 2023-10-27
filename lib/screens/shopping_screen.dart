import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/widgets/shopping_item_quickadd_view.dart';

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
  List<Item> quickaddedItems = [];

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
    relevantItems.addAll(quickaddedItems);
  }

  ListTile buildListTile(Item currentItem) {
    return ListTile(
      visualDensity: const VisualDensity(vertical: -4),
      leading: SizedBox(
          width: 240,
          child: Text(currentItem.title)),
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
  }

  @override
  Widget build(BuildContext context) {
    List<Pantry> pantryList = context.watch<PantryProvider>().pantriesList;
    filterItems(pantryList);

    SizedBox buildPantrySwitchList() {
      return SizedBox(
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
                    thumbColor: MaterialStateProperty.all(kColor6),
                    trackColor: MaterialStateProperty.all(kColor61),
                    onChanged: (newValue) {
                      context.read<PantryProvider>().switchPantrySelectedForShopping(currentPantry, newValue);
                    }),
              );
            }),
      );
    }

    SizedBox buildCheckboxList() {
      return SizedBox(
          width: double.maxFinite,
          height: (relevantItems.length + 1) * 60 <= 400
              ? 400
              : relevantItems.length * 60,
          child: ListView.builder(
            itemCount: relevantItems.length + 1,
            itemBuilder: (_, index) {
              return (index < relevantItems.length && relevantItems.isNotEmpty)
                  ? buildListTile(relevantItems[index])
              : ShoppingItemQuickAdd(quickaddedItems, filterItems); //Text('Quick add goes here');
            },
          ));
    }

    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
      children: [
          buildPantrySwitchList(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Divider(thickness: 2),
          ),
          buildCheckboxList()
      ],
    ),
        ));
  }
}

//TODO Add quickAdd textField to instantly add an item to the list that can be crossed off. Field has a button to add just to list or also to a pantry and to a category."