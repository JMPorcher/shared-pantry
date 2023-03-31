import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/widgets/item_tile.dart';

import '../models/item.dart';
import '../providers/item_list_provider.dart';
import 'package:shared_pantry/models/item_category.dart';
import 'add_dialog.dart';

class ExpandableItemList extends StatefulWidget {
  const ExpandableItemList({Key? key}) : super(key: key);

  @override
  State<ExpandableItemList> createState() => _ExpandableItemListState();
}

class _ExpandableItemListState extends State<ExpandableItemList> {

  @override
  Widget build(BuildContext context) {
    List<ItemCategory> categoryList = context.watch<ItemListProvider>().categoriesList;


    //Builds panels for the expandable panel list
    ExpansionPanel _generateExpansionPanel(ItemCategory category){
      return ExpansionPanel(
        isExpanded: category.isExpanded,
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Center(child: Text(category.title));
          },
          body: ListView.builder(
              shrinkWrap: true,
              itemCount: category.children.length,
              itemBuilder: (context, itemIndex) {
                return Dismissible(
                  onDismissed: (direction){
                    context.read<ItemListProvider>().removeItemAt(itemIndex);
                    //TODO: Update provider function
                  },
                  key: UniqueKey(),
                  child: ItemTile(
                    toggleSwitch: (_) => context.read<ItemListProvider>().toggleItemAvailability(category, itemIndex),
                    itemTitle: category.children[itemIndex].title,
                    isAvailable: category.children[itemIndex].isAvailable,
                  ),
                );
              }
          ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: ExpansionPanelList(
            expansionCallback: (index, isOpen) =>
                setState(() {
                  context.read<ItemListProvider>().categoriesList[index].toggleExpanded();
                }),
            children: categoryList.map((category) => _generateExpansionPanel(category)).toList()
            ),
      ),
    );
  }
}
