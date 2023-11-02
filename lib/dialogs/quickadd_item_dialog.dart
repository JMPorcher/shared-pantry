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
    final Function filterItems = widget.filterItems;
    final title = widget.title;

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
      Navigator.pop(context);
    }

    return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: FittedBox(
                child: Text(
                      'Add "$title"',
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold)
                  ),
              ),
            ),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: kColor4),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: DropdownButton<Pantry>(
                            hint: const Text('Choose pantry'),
                            value: chosenPantry,
                            items: pantryList
                                .map((pantry) => buildPantryWidget(pantry))
                                .toList(),
                            onChanged: (selectedPantry) {
                              setState(() {
                                chosenPantry = selectedPantry;
                              });
                            }),
                      ),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: DropdownButton<ItemCategory>(
                            disabledHint: Text(
                              'Choose pantry first',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.2)
                              ),
                            ),
                            hint: const Text('Choose category'),
                            value: chosenCategory,
                            items: chosenPantry?.categories
                                .map((category) => buildCategoryWidget(category))
                                .toList(),
                            onChanged: (selectedCategory) {
                              setState(() {
                                chosenCategory = selectedCategory;
                              });
                            }),
                      ),
                      SpButton(onTap: () {
                        chosenCategory?.add(Item(title));
                        Navigator.pop(context);
                        //addToShoppingList();
                      }, label: 'Save to pantry'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            TextButton(
                onPressed: () {
                  addToShoppingList();
                },
                child: const Text('Just to shopping list')),
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
//TODO Make a new provider for quickadd function
