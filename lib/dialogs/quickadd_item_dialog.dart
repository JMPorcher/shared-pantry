import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/item_category.dart';
import '../constants.dart';
import '../models/item.dart';
import '../models/pantry.dart';
import '../widgets/buttons.dart';

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
    final pantryStreams = context.watch<List<Stream<Pantry>>>();
    Future<List<Pantry>> getPantries(List<Stream<Pantry>> pantryStreams) async {
      var pantries = <Pantry>[];
      for (var pantryStream in pantryStreams) {
        await pantryStream.forEach((pantry) => pantries.add(pantry));
      }
      return pantries;
    }

    final Future<List<Pantry>> pantryList = getPantries(pantryStreams);

    final title = widget.title;

    chosenPantry ??= null; //pantries[0];
    chosenCategory ??= null; //categories[0];

    DropdownMenuItem<Pantry> buildPantryWidget(Pantry pantry) {
      return DropdownMenuItem(value: pantry, child: Text(pantry.title));
    }

    DropdownMenuItem<ItemCategory> buildCategoryWidget(ItemCategory category) {
      return DropdownMenuItem(value: category, child: Text(category.title));
    }

    void addToShoppingList() {
      widget.quickaddedItems.add(Item(widget.title));
      //widget.filterItems(pantryList);
    }



    return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TitleFittedBox(title: title),
            // buildPantryChooser(pantryList, buildPantryWidget,
            //     buildCategoryWidget, title, addToShoppingList, context),
            const SizedBox(height: 40),
            AddToShoppingListOnlyButton(addToShoppingList),
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

  Flexible buildPantryChooser(
      List<Pantry> pantryList,
      DropdownMenuItem<Pantry> Function(Pantry pantry) buildPantryWidget,
      DropdownMenuItem<ItemCategory> Function(ItemCategory category)
          buildCategoryWidget,
      String title,
      void Function() addToShoppingList,
      BuildContext context) {
    return Flexible(
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
              buildChosenPantryDropdown(pantryList, buildPantryWidget),
              buildChosenCategoryDropdown(buildCategoryWidget),
              AddToPantryButton(
                addToShoppingList,
                chosenCategory,
                title,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildChosenCategoryDropdown(
      DropdownMenuItem<ItemCategory> Function(ItemCategory category)
          buildCategoryWidget) {
    return Container(
      color: kColor11,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 50,
      child: DropdownButton<ItemCategory>(
        value: chosenCategory,
        items: chosenPantry?.categories
            .map((category) => buildCategoryWidget(category))
            .toList(),
        onChanged: (selectedCategory) {
          setState(() {
            chosenCategory = selectedCategory;
          });
        },
        dropdownColor: kColor11,
      ),
    );
  }

  Container buildChosenPantryDropdown(List<Pantry> pantryList,
      DropdownMenuItem<Pantry> Function(Pantry pantry) buildPantryWidget) {
    return Container(
      color: kColor11,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 50,
      child: DropdownButton<Pantry>(
        value: chosenPantry,
        items: pantryList.map((pantry) => buildPantryWidget(pantry)).toList(),
        onChanged: (selectedPantry) {
          setState(() {
            chosenPantry = selectedPantry;
            chosenCategory = selectedPantry?.categories[0];
          });
        },
        dropdownColor: kColor11,
      ),
    );
  }
}

class AddToPantryButton extends StatelessWidget {
  const AddToPantryButton(
    this.addToShoppingList,
    this.chosenCategory,
    this.title, {
    super.key,
  });

  final Function addToShoppingList;
  final ItemCategory? chosenCategory;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SpButton.filledButton(
        onTap: () {
          //chosenCategory?.add(Item(title));
          addToShoppingList();
          Navigator.pop(context);
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.summarize_outlined, color: Colors.white),
            Icon(Icons.add, color: Colors.white)
          ],
        ));
  }
}

class AddToShoppingListOnlyButton extends StatelessWidget {
  const AddToShoppingListOnlyButton(
    this.addToShoppingList, {
    super.key,
  });

  final Function addToShoppingList;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        addToShoppingList();
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: kColor5),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: const Offset(3, 3),
                  blurStyle: BlurStyle.normal,
                  blurRadius: 5)
            ]),
        padding: const EdgeInsets.all(8),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Just to shopping list',
                  style: TextStyle(color: Colors.black.withOpacity(0.7))),
              const SizedBox(width: 8),
              Icon(Icons.shopping_cart_checkout_outlined,
                  size: 16, color: Colors.black.withOpacity(0.7))
            ]),
      ),
    );
  }
}

class TitleFittedBox extends StatelessWidget {
  const TitleFittedBox({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: FittedBox(
        child: Text('Add "$title" to a Pantry?',
            maxLines: 2,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.7))),
      ),
    );
  }
}
