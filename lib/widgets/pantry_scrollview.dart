import 'package:flutter/material.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/models/item_category.dart';
import 'package:shared_pantry/widgets/pantry_appbar.dart';

import '../dialogs/add_category_dialog.dart';
import '../dialogs/edit_category_dialog.dart';
import '../models/pantry.dart';
import 'add_category_button.dart';
import 'category_tile.dart';
import 'category_view.dart';

class PantryScrollView extends StatelessWidget {
  const PantryScrollView({required this.currentPantry, Key? key})
      : super(key: key);

  final Pantry currentPantry;

  @override
  Widget build(BuildContext context) {
    final List<ItemCategory> currentCategoryList = currentPantry.categoryList;

    void showAddDialog() => showDialog(
        context: context,
        builder: (BuildContext context) => AddCategoryDialog(
              currentCategoryList: currentCategoryList,
            ));
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Scaffold(
            backgroundColor: kColor1,
            appBar: PantryAppBar(currentPantry: currentPantry),
            body: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: currentCategoryList.length,
                  key: UniqueKey(),
                  itemBuilder: (BuildContext context, int categoryIndex) {
                    ItemCategory currentCategory =
                        currentCategoryList[categoryIndex];
                    return Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        child: GestureDetector(
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    EditCategoryDialog(
                                        itemCategoryList: currentCategoryList,
                                        itemCategory: currentCategory));
                          },
                          child: CategoryTile(currentCategoryList: currentCategoryList, currentCategory: currentCategory),
                        ));
                  },
                ), //Contents of one Pantry
                AddCategoryButton(currentCategoryList: currentCategoryList)
              ],
            )),
      ),
    );
  }
}




