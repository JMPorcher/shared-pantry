import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/dialogs/edit_category_dialog.dart';
import 'package:shared_pantry/widgets/item_tile.dart';

import '../models/item.dart';
import '../providers/category_list_provider.dart';
import 'package:shared_pantry/models/item_category.dart';

import '../dialogs/add_item_dialog.dart';
import '../dialogs/delete_category_dialog.dart';

class ExpandableCategoryList extends StatefulWidget {
  const ExpandableCategoryList({Key? key}) : super(key: key);

  @override
  State<ExpandableCategoryList> createState() => _ExpandableCategoryListState();
}

class _ExpandableCategoryListState extends State<ExpandableCategoryList> {
  @override
  Widget build(BuildContext context) {
    List<ItemCategory> categoryList =
        context.watch<CategoryListProvider>().categoriesList;

    return Scaffold(
        body: SingleChildScrollView(
            child: ListView.builder(
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
                            categoryIndex:
                                categoryList.indexOf(currentCategory)));
                  },
                  icon: Icons.edit,
                ),
                SlidableAction(
                  onPressed: (context) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => DeleteCategoryDialog(
                        categoryIndex: categoryList.indexOf(currentCategory),
                        categoryTitle: categoryList.isEmpty
                            ? ''
                            : context
                                .watch<CategoryListProvider>()
                                .categoriesList[index]
                                .title,
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
              child: ExpansionTile(
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
                                    categoryList.indexOf(currentCategory)]
                                .items[itemIndex];
                            return Dismissible(
                              onDismissed: (direction) {
                                context
                                    .read<CategoryListProvider>()
                                    .removeItemAt(
                                        categoryList.indexOf(currentCategory),
                                        itemIndex);
                              },
                              key: UniqueKey(),
                              child: ItemTile(
                                toggleSwitch: (_) => context
                                    .read<CategoryListProvider>()
                                    .toggleItemAvailability(
                                        categoryList.indexOf(currentCategory),
                                        itemIndex),
                                itemTitle: currentItem.title,
                                isAvailable: currentItem.isAvailable,
                              ),
                            );
                          }),
                      MaterialButton(
                          onPressed: () => showDialog(
                              context: context,
                              builder: (BuildContext context) => AddItemDialog(
                                  categoryIndex:
                                      categoryList.indexOf(currentCategory))),
                          child: const Icon(
                            Icons.add,
                            size: 40.0,
                          )),
                    ],
                  )
                ],
              ),
            ));
      },
    )));
  }
}
