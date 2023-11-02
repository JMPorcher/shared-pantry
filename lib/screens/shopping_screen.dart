import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/widgets/shopping_item_quickadd_view.dart';

import '../models/item.dart';
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
    pantryList.where((pantry) => pantry.selectedForShopping).forEach((pantry) {
      relevantItems.addAll(pantry.categories.expand(
          (category) => category.items.where((item) => !item.isAvailable)));
    });
    relevantItems.addAll(quickaddedItems);
  }

  ListTile buildListTile(Item currentItem, Color backgroundColor) {
    return ListTile(
        tileColor: backgroundColor,
      visualDensity: const VisualDensity(vertical: -4),
      leading: SizedBox(width: 240, child: Text(currentItem.title)),
      trailing: Checkbox(
        value: currentItem.isAvailable,
        onChanged: (bool? value) {
          setState(() {
            if (quickaddedItems.contains(currentItem)) {
              quickaddedItems.remove(currentItem);
            } else {
              context
                  .read<PantryProvider>()
                  .toggleItemAvailability(currentItem);
            }
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PantryProvider pantryProvider = context.watch<PantryProvider>();
    final List<Pantry> pantryList = pantryProvider.pantriesList;
    filterItems(pantryList);

    SizedBox buildPantrySwitchList() {
      return SizedBox(
        width: double.maxFinite,
        height: pantryList.length * 40 + 20,
        child: ListView.builder(
            itemCount: pantryList.length,
            itemExtent: 40,
            itemBuilder: (_, index) {
              final Pantry currentPantry = pantryList[index];
              return ListTile(
                leading: Text(currentPantry.title),
                trailing: Switch(
                    value: currentPantry.selectedForShopping,
                    thumbColor: MaterialStateProperty.all(kColor6),
                    trackColor: MaterialStateProperty.all(kColor61),
                    onChanged: (newValue) {
                      pantryProvider.togglePantrySelectedForShopping(
                          currentPantry, newValue);
                    }),
              );
            }),
      );
    }

    SizedBox buildCheckboxList() {
      return SizedBox(
          width: double.maxFinite,
          height: (relevantItems.length + 1) * 50 <= 400
              ? 400
              : relevantItems.length * 60,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: relevantItems.length + 1,
            itemBuilder: (_, index) {
              final Color backgroundColor = index.isEven
                  ? kColor1
                  : kColor11.withOpacity(0.2);
              return (index < relevantItems.length && relevantItems.isNotEmpty)
                  ? buildListTile(relevantItems[index], backgroundColor)
                  : ShoppingItemQuickAdd(quickaddedItems,
                      filterItems, backgroundColor); //Text('Quick add goes here');
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
          Consumer<PantryProvider>(builder: (context, pantryProvider, child) {
            filterItems(pantryList);
            return buildCheckboxList();
          })
        ],
      ),
    ));
  }
}

//TODO Add quickAdd textField to instantly add an item to the list that can be crossed off. Field has a button to add just to list or also to a pantry and to a category."
