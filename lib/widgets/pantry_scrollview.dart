import 'package:flutter/material.dart';
import 'package:shared_pantry/models/item_category.dart';
import 'package:shared_pantry/widgets/pantry_appbar.dart';

import '../dialogs/add_category_dialog.dart';
import '../dialogs/edit_category_dialog.dart';
import '../models/pantry.dart';
import 'item_category_view.dart';

class PantryScrollView extends StatelessWidget {
  const PantryScrollView(
      {required this.currentPantry, Key? key}): super(key: key);

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
          backgroundColor: Colors.blue,
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black12, width: 2),
                        ),
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
                          child: ExpansionTile(
                            initiallyExpanded:
                                currentCategoryList[categoryIndex].isExpanded,
                            onExpansionChanged: (_) {
                              currentCategoryList[categoryIndex].toggleExpanded();
                            },
                            title: Center(child: Text(currentCategory.title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),)),
                            backgroundColor: const Color(0x99AAD9FF),
                            collapsedBackgroundColor: const Color(0x99AAD9FF),
                            children: [
                              ItemCategoryView(itemList: currentCategory.items)
                            ],
                          ),
                        ));
                  },
                ), //Contents of one Pantry
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(top: 6, left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.grey,
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
                )
              ],
            )),
      ),
    );
  }
}
