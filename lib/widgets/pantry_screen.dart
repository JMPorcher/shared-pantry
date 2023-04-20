import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/dialogs/edit_category_dialog.dart';
import 'package:shared_pantry/widgets/item_listview_column.dart';

import '../dialogs/add_category_dialog.dart';
import '../dialogs/shopping_list_dialog.dart';
import '../models/pantry.dart';
import '../providers/pantry_list_provider.dart';
import 'package:shared_pantry/models/item_category.dart';

import '../dialogs/delete_category_dialog.dart';

class PantryScreen extends StatefulWidget {
  const PantryScreen({Key? key}) : super(key: key);

  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {


  @override
  Widget build(BuildContext context) {
    List<Pantry> pantryList =
        context
            .watch<PantryListProvider>()
            .pantriesList;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Shared Pantry'),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                      const ShoppingListDialog());
                }),
          ],
        ),
        body: PageView.builder(
            itemCount: pantryList.length,
            itemBuilder: (context, pantryIndex) {
              Pantry currentPantry = pantryList[pantryIndex];
              SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: currentPantry.categoryList.length,
                      key: UniqueKey(),
                      itemBuilder: (BuildContext context, int categoryIndex) {
                        ItemCategory currentCategory = currentPantry.categoryList[categoryIndex];
                        return Slidable(
                            endActionPane: ActionPane(
                              extentRatio: 0.4,
                              motion: const BehindMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            EditCategoryDialog(
                                                categoryIndex: currentPantry.categoryList
                                                    .indexOf(currentCategory), pantryIndex: pantryList.indexOf(currentPantry),));
                                  },
                                  icon: Icons.edit,
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          DeleteCategoryDialog(
                                            currentCategory:
                                            currentPantry.categoryList.indexOf(
                                                currentCategory),
                                            categoryTitle: currentPantry.categoryList.isEmpty
                                                ? ''
                                                : currentPantry.categoryList[categoryIndex].title,
                                          ),
                                    );
                                  },
                                  icon: Icons.delete,
                                ),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: Colors.black12, width: 2),
                              ),
                              margin: const EdgeInsets.only(bottom: 4),
                              child: ExpansionTile(
                                initiallyExpanded: currentPantry.categoryList[categoryIndex].isExpanded,
                                onExpansionChanged: (_) {
                                  currentPantry.categoryList[categoryIndex].toggleExpanded();
                                },
                                title: Center(
                                    child: Text(currentCategory.title)),
                                collapsedBackgroundColor: const Color(
                                    0x5BAAD9FF),
                                children: [
                                  ItemListViewColumn(itemList: currentCategory)
                                ],
                              ), //Category tile that can be expanded
                            ));
                      },
                    ), //Contents of one Pantry
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(
                          top: 6, left: 20, right: 20),
                      decoration: const BoxDecoration(
                          color: Colors.grey, boxShadow: [
                        BoxShadow(
                            offset: Offset(3, 3),
                            blurStyle: BlurStyle.normal,
                            blurRadius: 5)
                      ]),
                      child: MaterialButton(
                          onPressed: () => showAddDialog(),
                          child: currentPantry.categoryList.isEmpty
                              ? const Text(
                            '(  Add your first category  )',
                            style: TextStyle(color: Colors.white),
                          )
                              : const Text('Add new category',
                              style: TextStyle(color: Colors.white))),
                    )
                  ],
                ),
              );
            }
        ));
  }
}
