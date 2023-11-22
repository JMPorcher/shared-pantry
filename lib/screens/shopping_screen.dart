import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/widgets/quickadd_view.dart';

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

  @override
  Widget build(BuildContext context) {
    final PantryProvider pantryProvider = context.watch<PantryProvider>();
    final List<Pantry> pantryList = pantryProvider.pantriesList;
    filterItems(pantryList);
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              buildPantrySwitchList(pantryProvider),
              const DividerLine(),
              Consumer<PantryProvider>(builder: (context, pantryProvider, child) {
                filterItems(pantryList);
                return buildCheckboxList();
              })
            ],
          ),
        ));
  }


  SizedBox buildPantrySwitchList(PantryProvider pantryProvider) {
    final List<Pantry> pantryList = pantryProvider.pantriesList;
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
                  thumbColor: MaterialStateColor.resolveWith(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return kColor6;
                        }
                        return kColor1;
                      }),
                  trackColor: MaterialStateProperty.all(kColor61),
                  onChanged: (newValue) {
                    pantryProvider.togglePantrySelectedForShopping(
                        currentPantry, newValue);
                  }),
            );
          }),
    );
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
            final Color backgroundColor =
            index.isEven ? kColor1 : kColor11.withOpacity(0.2);
            return (index < relevantItems.length && relevantItems.isNotEmpty)
                ? buildListTile(relevantItems[index], backgroundColor)
                : ShoppingItemQuickAdd(quickaddedItems, filterItems,
                backgroundColor); //Text('Quick add goes here');
          },
        ));
  }
}

class DividerLine extends StatelessWidget {
  const DividerLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Divider(thickness: 2),
    );
  }
}
