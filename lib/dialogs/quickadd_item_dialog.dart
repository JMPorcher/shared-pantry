import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/models/item_category.dart';
import 'package:shared_pantry/providers/pantry_provider.dart';
import 'package:shared_pantry/widgets/add_button.dart';

import '../constants.dart';
import '../models/item.dart';
import '../models/pantry.dart';

class QuickaddItemDialog extends StatefulWidget {
  const QuickaddItemDialog(this.quickaddedItems, this.title, this.filterItems,
      {super.key});

  final Function filterItems;
  final List<Item> quickaddedItems;
  final String title;

  @override
  State<QuickaddItemDialog> createState() => _QuickaddItemDialogState();
}

class _QuickaddItemDialogState extends State<QuickaddItemDialog> {
  final ValueNotifier<String> categoryTitleValueNotifier =
      ValueNotifier<String>('');

  final titleTextController = TextEditingController();

  Pantry? chosenPantry;
  ItemCategory? chosenCategory;

  @override
  Widget build(BuildContext context) {
    titleTextController.text = categoryTitleValueNotifier.value;
    final PantryProvider pantryProvider = context.watch<PantryProvider>();
    final pantryList = pantryProvider.pantriesList;
    final List<String> pantryListTitles = [];
    for (var pantry in pantryList) {
      pantryListTitles.add(pantry.title);
    }

    final title = widget.title;

    chosenPantry ??= pantryList[0];
    chosenCategory ??= pantryList[0].categories[0];

    DropdownMenuItem<Pantry> buildPantryWidget(Pantry pantry) {
      return DropdownMenuItem(value: pantry, child: Text(pantry.title));
    }

    DropdownMenuItem<ItemCategory> buildCategoryWidget(ItemCategory category) {
      return DropdownMenuItem(value: category, child: Text(category.title));
    }

    void addToShoppingList() {
      widget.quickaddedItems.add(Item(widget.title));
      widget.filterItems(pantryList);
      pantryProvider.updateState();
    }

    return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: FittedBox(
                child: Text('Add "$title" to a Pantry?',
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.7)
                    )),
              ),
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                // decoration: BoxDecoration(
                //   border: Border.all(width: 2, color: Colors.black.withOpacity(0.2)),
                // ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        color: kColor11,
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        height: 50,
                        child: DropdownButton<Pantry>(
                            value: chosenPantry,
                            items: pantryList
                                .map((pantry) => buildPantryWidget(pantry))
                                .toList(),
                            onChanged: (selectedPantry) {
                              setState(() {
                                chosenPantry = selectedPantry;
                                chosenCategory = selectedPantry?.categories[0];
                              });
                            },
                          dropdownColor: kColor11,
                        ),
                      ),
                      Container(
                        color: kColor11,
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        height: 50,
                        child: DropdownButton<ItemCategory>(
                            value: chosenCategory,
                            items: chosenPantry?.categories
                                .map(
                                    (category) => buildCategoryWidget(category))
                                .toList(),
                            onChanged: (selectedCategory) {
                              setState(() {
                                chosenCategory = selectedCategory;
                              });
                            },
                          dropdownColor: kColor11,
                        ),
                      ),
                      SpButton(
                          onTap: () {
                            chosenCategory?.add(Item(title));
                            addToShoppingList();
                            Navigator.pop(context);
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.summarize_outlined, color: Colors.white),
                              Icon(Icons.add, color: Colors.white)
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            MaterialButton(
              onPressed: () {
                addToShoppingList();
                Navigator.pop(context);
              },
              child:
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                        border:  Border.all(width: 1, color: kColor5),
                        borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: const Offset(3, 3),
                            blurStyle: BlurStyle.normal,
                            blurRadius: 5
                        )
                      ]
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
                Text('Just to shopping list', style: TextStyle(color: Colors.black.withOpacity(0.7))),
                const SizedBox(width: 8),
                Icon(Icons.shopping_cart_checkout_outlined, size: 16, color: Colors.black.withOpacity(0.7))
              ]),
                  ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'))
        ]);
  }
}
