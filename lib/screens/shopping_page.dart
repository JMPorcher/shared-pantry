import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/widgets/shopping_item_quickadd_view.dart';
import 'package:shared_pantry/widgets/sp_switch.dart';

import '../models/item.dart';
import '../models/pantry.dart';
import '../providers/pantry_provider.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  List<Item> relevantItems = [];
  List<Item> quickaddedItems = [];
  late List<Pantry> pantryList;

  void filterItems(List<Pantry> pantries) {
    //Loop through pantries and use DatabaseService to retrieve all unavailable items
    relevantItems.addAll(quickaddedItems);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  pantryList = context.watch<PantryProvider>().pantries;
    //filterItems(pantryProviders);
    return Scaffold(
      appBar: AppBar(title: const Text('My Shopping List', style: TextStyle(color: kColor1)), centerTitle: true, backgroundColor: kColor51),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const PantryFilterInfoText(),
                (pantryList.isNotEmpty) ? buildPantrySwitchList() : const Text('No pantries yet'),
                const DividerLine(),
                const ItemsInfoText(),
                buildCheckboxList()
              ],
            ),
          )),
    );
  }


  SizedBox buildPantrySwitchList() {
    return SizedBox(
      width: double.maxFinite,
      height: (pantryList.length) * 40 + 20,
      child: ListView.builder(
          itemCount: pantryList.isEmpty ? 1 : pantryList.length,
          itemExtent: 40,
          itemBuilder: (_, index) {
            Pantry pantry = pantryList[index];
            return ListTile(
              leading: Text(pantry.title),
              trailing: SpSwitch(
                switchValue: pantry.selectedForShopping,
                toggleSwitch: (newValue) => {}
                  //pantryProvider.togglePantrySelectedForShopping(currentPantry, newValue),
              )
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
              // context
              //     .read<PantryProvider>()
              //     .toggleItemAvailability(currentItem);
            }
          });
        },
      ),
    );
  }

  ListView buildCheckboxList() {
    return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: relevantItems.length + 1,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            final Color backgroundColor =
            index.isEven ? kColor1 : kColor11.withOpacity(0.2);
            return (index < relevantItems.length && relevantItems.isNotEmpty)
                ? buildListTile(relevantItems[index], backgroundColor)
                : ShoppingItemQuickAdd(quickaddedItems, filterItems,
                backgroundColor);
          },
        );
  }
}

class ItemsInfoText extends StatelessWidget {
  const ItemsInfoText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('Items that ran out:', style: TextStyle(fontSize: 11), textAlign: TextAlign.start,),
      ],
    );
  }
}

class PantryFilterInfoText extends StatelessWidget {
  const PantryFilterInfoText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('Choose pantries you want to shop for:', style: TextStyle(fontSize: 11), textAlign: TextAlign.start,),
      ],
    );
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

//TODO Sign-out appears to be automatically called.