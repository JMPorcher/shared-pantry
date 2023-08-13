import 'package:flutter/material.dart';

import '../constants.dart';
import '../dialogs/add_category_dialog.dart';
import '../models/item_category.dart';

class AddCategoryButton extends StatelessWidget {
  const AddCategoryButton({
    super.key,
    required this.currentCategoryList,
  });

  final List<ItemCategory> currentCategoryList;

  @override
  Widget build(BuildContext context) {

    void showAddDialog() => showDialog(
        context: context,
        builder: (BuildContext context) => AddCategoryDialog(
          currentCategoryList: currentCategoryList,
        ));
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 6, left: 20, right: 20),
      decoration: BoxDecoration(
          color: kColor5,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                offset: Offset(3, 3),
                blurStyle: BlurStyle.normal,
                blurRadius: 5)
          ]),
      child: MaterialButton(
          onPressed: () => showAddDialog(),
          child: currentCategoryList.isEmpty
              ? const Text(
            '(  Add your first category  )',
            style: TextStyle(color: Colors.white),
          )
              : const Text('Add new category',
              style: TextStyle(color: Colors.white))),
    );
  }
}