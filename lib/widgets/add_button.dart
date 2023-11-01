import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/providers/pantry_provider.dart';

import '../constants.dart';
import '../dialogs/add_category_dialog.dart';
import '../dialogs/add_pantry_dialog.dart';
import '../models/item.dart';
import '../models/item_category.dart';

class SpButton extends StatelessWidget {
  const SpButton(this.buttonType, this.currentCategoryList, this.itemCategory, this.newItem);

  const SpButton.quickadd(
      {super.key, required this.itemCategory, required this.newItem}) :  currentCategoryList = const [],
        buttonType = ButtonType.quickaddItem;

  const SpButton.category({
    super.key,
    required this.currentCategoryList,
  })  : buttonType = ButtonType.category,
        itemCategory = null,
        newItem = null;

  const SpButton.pantry({
    super.key,
  })  : currentCategoryList = const [],
        buttonType = ButtonType.pantry,
  itemCategory = null,
        newItem = null
  ;


  final ButtonType buttonType;
  final List<ItemCategory>? currentCategoryList;
  final ItemCategory? itemCategory;
  final Item? newItem;

  @override
  Widget build(BuildContext context) {
    final PantryProvider pantryProvider = context.watch<PantryProvider>();
    final pantryList = pantryProvider.pantriesList;

    void showAddCategoryDialog() => showDialog(
        context: context,
        builder: (BuildContext context) => AddCategoryDialog(
              currentCategoryList: currentCategoryList ?? [],
            ));

    void showAddPantryDialog() => showDialog(
        context: context, builder: (BuildContext context) => AddPantryDialog());


    MaterialButton buildAddPantryButton() {
      final String label =
          pantryList.isEmpty ? 'Add your first pantry' : 'Add a pantry';
      return MaterialButton(
          onPressed: () => {showAddPantryDialog()},
          child: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ));
    }

    MaterialButton buildAddCategoryButton() {
      final String label =
          pantryList.isEmpty ? 'Add your first category' : 'Add new category';
      return MaterialButton(
          onPressed: () => showAddCategoryDialog(),
          child: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ));
    }

    MaterialButton buildQuickaddButton(ItemCategory? category, Item? newItem) {
      const String label = 'Add to pantry';
      return MaterialButton(
          onPressed: () {
            if (category != null && newItem != null) {
              pantryProvider.addItem(category, newItem);
              Navigator.pop(context);
            }
          },
          child: const Text(
            label,
            style: TextStyle(color: Colors.white),
          ));
    }

    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        margin: const EdgeInsets.only(top: 6, left: 20, right: 20, bottom: 20),
        decoration: BoxDecoration(
            color: kColor5,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(3, 3),
                  blurStyle: BlurStyle.normal,
                  blurRadius: 5)
            ]),
        child: buttonType == ButtonType.pantry
        ? buildAddPantryButton()
        : buttonType == ButtonType.category
            ? buildAddCategoryButton()
            : buildQuickaddButton(itemCategory, newItem)
    );
  }
}

enum ButtonType { pantry, category, quickaddItem }
