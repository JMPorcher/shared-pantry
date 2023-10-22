import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/providers/pantry_provider.dart';

import '../constants.dart';
import '../dialogs/add_category_dialog.dart';
import '../dialogs/add_pantry_dialog.dart';
import '../models/item_category.dart';

class AddButton extends StatelessWidget {
  const AddButton.category({
    super.key,
    required this.currentCategoryList,
  }) : isCategoryButton = true;

  const AddButton.pantry({
    super.key,
  })  : currentCategoryList = const [],
        isCategoryButton = false;

  final List<ItemCategory> currentCategoryList;
  final bool isCategoryButton;

  @override
  Widget build(BuildContext context) {
    final pantryList = context.watch<PantryProvider>().pantriesList;

    void showAddCategoryDialog() => showDialog(
        context: context,
        builder: (BuildContext context) => AddCategoryDialog(
              currentCategoryList: currentCategoryList,
            ));

    void showAddPantryDialog() => showDialog(
        context: context, builder: (BuildContext context) => AddPantryDialog());

    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
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
        child: isCategoryButton
            ? MaterialButton(
                onPressed: () => showAddCategoryDialog(),
                child: currentCategoryList.isEmpty
                    ? const Text(
                        'Add your first category',
                        style: TextStyle(color: Colors.white),
                      )
                    : const Text('Add new category',
                        style: TextStyle(color: Colors.white)))
            : MaterialButton(
                onPressed: () => showAddPantryDialog(),
                child: pantryList.isEmpty
                    ? const Text(
                        'Add your first pantry',
                        style: TextStyle(color: Colors.white),
                      )
                    : const Text(
                        'Add a pantry',
                        style: TextStyle(color: Colors.white),
                      )));
  }
}
