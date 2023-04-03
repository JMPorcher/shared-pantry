import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/widgets/item_tile.dart';

import '../providers/item_list_provider.dart';
import 'package:shared_pantry/models/item_category.dart';

import 'add_item_dialog.dart';

class ExpandableItemList extends StatefulWidget {
  const ExpandableItemList({Key? key}) : super(key: key);

  @override
  State<ExpandableItemList> createState() => _ExpandableItemListState();
}

class _ExpandableItemListState extends State<ExpandableItemList> {
  @override
  Widget build(BuildContext context) {
    List<ItemCategory> categoryList =
        context
            .watch<ItemListProvider>()
            .categoriesList;

    
    ExpansionPanel generateExpansionPanel(ItemCategory category) {
      void showAddItemDialog() =>
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  AddItemDialog(categoryIndex: categoryList.indexOf(category))
          );

      return ExpansionPanel(
        isExpanded: categoryList[categoryList.indexOf(category)].isExpanded,
        canTapOnHeader: true,
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Center(child: Text(category.title));
        },
        body: Column(
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
                  toggleSwitch: (_) =>
                      context
                          .read<ItemListProvider>()
                          .toggleItemAvailability(
                          categoryList.indexOf(category), itemIndex),
                  itemTitle: categoryList[categoryList.indexOf(category)]
                      .items[itemIndex].title,
                  isAvailable: categoryList[categoryList.indexOf(category)]
                      .items[itemIndex].isAvailable,
                ),
              );
            }),
        MaterialButton(
            onPressed: () => showAddItemDialog(),
            child: const Icon(Icons.add, size: 40.0,)
        ),
      ],
      )
      ,
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: ExpansionPanelList(
            expansionCallback: (index, isOpen) =>
                setState(() {
                  context
                      .read<ItemListProvider>()
                      .toggleCategoryIsExpanded(index);
                }),
            children: categoryList
                .map((category) => generateExpansionPanel(category))
                .toList()),
      ),
    );
  }
}
