import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/widgets/item_tile.dart';

import '../providers/item_list_provider.dart';
import 'package:shared_pantry/models/item_category.dart';

import 'add_item_dialog.dart';

class ExpandableCategoryList extends StatefulWidget {
  const ExpandableCategoryList({Key? key}) : super(key: key);

  @override
  State<ExpandableCategoryList> createState() => _ExpandableCategoryListState();
}

class _ExpandableCategoryListState extends State<ExpandableCategoryList> {
  @override
  Widget build(BuildContext context) {
    List<ItemCategory> categoryList =
        context.watch<ItemListProvider>().categoriesList;

    Slidable generateSlidableExpansionTile(ItemCategory category) {
      void showAddItemDialog() => showDialog(
          context: context,
          builder: (BuildContext context) =>
              AddItemDialog(categoryIndex: categoryList.indexOf(category)));

      return Slidable(
          child: ExpansionTile(
        title: Center(child: Text(category.title)),
        children: [
          Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: category.items.length,
                  itemBuilder: (context, itemIndex) {
                    return Dismissible(
                      onDismissed: (direction) {
                        context.read<ItemListProvider>().removeItemAt(
                            categoryList.indexOf(category), itemIndex);
                      },
                      key: UniqueKey(),
                      child: ItemTile(
                        toggleSwitch: (_) => context
                            .read<ItemListProvider>()
                            .toggleItemAvailability(
                                categoryList.indexOf(category), itemIndex),
                        itemTitle: categoryList[categoryList.indexOf(category)]
                            .items[itemIndex]
                            .title,
                        isAvailable:
                            categoryList[categoryList.indexOf(category)]
                                .items[itemIndex]
                                .isAvailable,
                      ),
                    );
                  }),
              MaterialButton(
                  onPressed: () => showAddItemDialog(),
                  child: const Icon(
                    Icons.add,
                    size: 40.0,
                  )),
            ],
          )
        ],
      ));
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: ListView.builder(
        key: UniqueKey(),
        itemBuilder: (BuildContext context, int index) {
          categoryList
              .map((category) => generateSlidableExpansionTile(category))
              .toList();
        },
      ),
    ));
  }
}

/*
return Scaffold(
  body: SingleChildScrollView(
    child: ExpansionPanelList(
      key: UniqueKey(),
      expansionCallback: (index, isOpen) =>
        setState(() {
        context
        .read<ItemListProvider>()
        .toggleCategoryIsExpanded(index);
        }
),
children: categoryList
    .map((category) => generateExpansionPanel(category))
    .toList()),
),
);*/
