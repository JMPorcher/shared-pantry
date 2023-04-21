import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_pantry/models/item_category.dart';

import '../dialogs/add_category_dialog.dart';
import '../dialogs/delete_category_dialog.dart';
import '../dialogs/edit_category_dialog.dart';
import '../dialogs/shopping_list_dialog.dart';
import 'item_listview_column.dart';

class CategoryListViewColumn extends StatelessWidget {
  const CategoryListViewColumn({required this.currentCategoryList, Key? key, required this.currentTitle}) : super(key: key);

  final List<ItemCategory> currentCategoryList;
  final String currentTitle;

  @override
  Widget build(BuildContext context) {

    void showAddDialog() =>
        showDialog(
            context: context,
            builder: (BuildContext context) => AddCategoryDialog(currentCategoryList: currentCategoryList,));

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        appBar: AppBar(
          title: Text(currentTitle),
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
        body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: currentCategoryList.length,
            key: UniqueKey(),
            itemBuilder: (BuildContext context, int categoryIndex) {
              ItemCategory currentCategory = currentCategoryList[categoryIndex];
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
                                    itemCategory: currentCategory));
                        },
                        icon: Icons.edit,
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                DeleteCategoryDialog(
                                  currentCategory: currentCategory,
                                  currentCategoryList: currentCategoryList
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
                      initiallyExpanded: currentCategoryList[categoryIndex].isExpanded,
                      onExpansionChanged: (_) {
                        currentCategoryList[categoryIndex].toggleExpanded();
                      },
                      title: Center(
                          child: Text(currentCategory.title)),
                      collapsedBackgroundColor: const Color(
                          0x5BAAD9FF),
                      children: [
                        ItemListViewColumn(itemList: currentCategory.items)
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
    );
  }
}
