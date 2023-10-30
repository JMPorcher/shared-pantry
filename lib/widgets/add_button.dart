import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/providers/pantry_provider.dart';

import '../constants.dart';
import '../dialogs/add_category_dialog.dart';
import '../dialogs/add_pantry_dialog.dart';
import '../models/item_category.dart';

class AddButton extends StatelessWidget {
  const AddButton.quickadd(
      {super.key}) :  currentCategoryList = const [],
        buttonType = ButtonType.quickaddItem;

  const AddButton.category({
    super.key,
    required this.currentCategoryList,
  })  : buttonType = ButtonType.category;

  const AddButton.pantry({
    super.key,
  })  : currentCategoryList = const [],
        buttonType = ButtonType.pantry;


  final ButtonType buttonType;
  final List<ItemCategory>? currentCategoryList;

  @override
  Widget build(BuildContext context) {
    final pantryList = context.watch<PantryProvider>().pantriesList;

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

    MaterialButton buildQuickaddButton() {
      const String label = 'Working on this';

      return MaterialButton(
          onPressed: () {},
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
            : buildQuickaddButton()
    );
  }
}

enum ButtonType { pantry, category, quickaddItem }
