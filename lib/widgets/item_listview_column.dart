import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dialogs/add_item_dialog.dart';
import '../models/item.dart';
import '../providers/pantry_list_provider.dart';
import 'item_tile.dart';

class ItemListViewColumn extends StatelessWidget {
  const ItemListViewColumn({required this.itemList, Key? key})
      : super(key: key);

  final List<Item> itemList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliverList(
            delegate: SliverChildBuilderDelegate(
                childCount: itemList.length,
                (context, itemIndex) {
          Item currentItem = itemList[itemIndex];
          return Dismissible(
            onDismissed: (direction) {
              context.read<PantryProvider>().removeItem(itemList, currentItem);
            },
            key: UniqueKey(),
            child: ItemTile(
              toggleSwitch: (_) => context
                  .read<PantryProvider>()
                  .toggleItemAvailability(currentItem),
              itemTitle: currentItem.title,
              isAvailable: currentItem.isAvailable,
            ),
          );
        })),
        MaterialButton(
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) =>
                    AddItemDialog(currentItemList: itemList)),
            child: const Text(
              'Add item',
              style: TextStyle(color: Colors.black54),
            )),
        // Button that adds an item to a category
      ],
    );
  }
}
