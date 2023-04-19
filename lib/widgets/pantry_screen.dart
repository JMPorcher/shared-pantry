import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/dialogs/edit_category_dialog.dart';
import 'package:shared_pantry/widgets/item_tile.dart';

import '../dialogs/add_category_dialog.dart';
import '../models/item.dart';
import '../providers/category_list_provider.dart';
import 'package:shared_pantry/models/item_category.dart';

import '../dialogs/add_item_dialog.dart';
import '../dialogs/delete_category_dialog.dart';

class ListsScreen extends StatefulWidget {
  const ListsScreen({Key? key}) : super(key: key);

  @override
  State<ListsScreen> createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  void showAddDialog() => showDialog(
      context: context,
      builder: (BuildContext context) => const AddCategoryDialog());

  @override
  Widget build(BuildContext context) {
    List<ItemCategory> categoryList =
        context.watch<CategoryListProvider>().categoriesList;

    return Scaffold(body: PageView.builder(
      itemBuilder: (BuildContext context, int index) {
        SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: categoryList.length,
                key: UniqueKey(),
                itemBuilder: (BuildContext context, int index) {
                  ItemCategory currentCategory = categoryList[index];
                  return Slidable(
                      endActionPane: ActionPane(
                        extentRatio: 0.4,
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              showDialog(
                                  context: context,
                                  builder: (context) => EditCategoryDialog(
                                      categoryIndex: categoryList
                                          .indexOf(currentCategory)));
                            },
                            icon: Icons.edit,
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    DeleteCategoryDialog(
                                  categoryIndex:
                                      categoryList.indexOf(currentCategory),
                                  categoryTitle: categoryList.isEmpty
                                      ? ''
                                      : categoryList[index].title,
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
                          border: Border.all(color: Colors.black12, width: 2),
                        ),
                        margin: const EdgeInsets.only(bottom: 4),
                        child: ExpansionTile(
                          initiallyExpanded: currentCategory.isExpanded,
                          onExpansionChanged: (_) {
                            currentCategory.toggleExpanded();
                          },
                          title: Center(child: Text(currentCategory.title)),
                          collapsedBackgroundColor: const Color(0x5BAAD9FF),
                          children: [
                            Column(
                              children: [
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: currentCategory.items.length,
                                    itemBuilder: (context, itemIndex) {
                                      Item currentItem = categoryList[
                                              categoryList
                                                  .indexOf(currentCategory)]
                                          .items[itemIndex];
                                      return Dismissible(
                                        onDismissed: (direction) {
                                          context
                                              .read<CategoryListProvider>()
                                              .removeItemAt(
                                                  categoryList
                                                      .indexOf(currentCategory),
                                                  itemIndex);
                                        },
                                        key: UniqueKey(),
                                        child: ItemTile(
                                          toggleSwitch: (_) => context
                                              .read<CategoryListProvider>()
                                              .toggleItemAvailability(
                                                  categoryList
                                                      .indexOf(currentCategory),
                                                  itemIndex),
                                          itemTitle: currentItem.title,
                                          isAvailable: currentItem.isAvailable,
                                        ),
                                      );
                                    }),
                                MaterialButton(
                                    onPressed: () => showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AddItemDialog(
                                                categoryIndex: categoryList
                                                    .indexOf(currentCategory))),
                                    child: Text(
                                      'Add item',
                                      style: TextStyle(
                                          color: Colors.blue.shade100),
                                    )),
                                // Button that adds an item to a category
                              ],
                            )
                          ],
                        ), //Category tile that can be expanded
                      ));
                },
              ), //Contents of one Pantry
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(top: 6, left: 20, right: 20),
                decoration: const BoxDecoration(color: Colors.grey, boxShadow: [
                  BoxShadow(
                      offset: Offset(3, 3),
                      blurStyle: BlurStyle.normal,
                      blurRadius: 5)
                ]),
                child: MaterialButton(
                    onPressed: () => showAddDialog(),
                    child: categoryList.isEmpty
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
      },
    ));
  }
}
