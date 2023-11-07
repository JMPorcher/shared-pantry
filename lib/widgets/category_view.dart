import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/models/item_category.dart';

import '../dialogs/add_item_dialog.dart';
import '../models/item.dart';
import '../providers/pantry_provider.dart';
import 'item_tile.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({required this.itemCategory, super.key});

  final ItemCategory itemCategory;

  @override
  Widget build(BuildContext context) {

    ListView buildItemList() {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCategory.items.length,
        itemBuilder: (_, index) {
          Item currentItem = itemCategory.items[index];
          return Dismissible(
            direction: DismissDirection.endToStart,
            onDismissed: (_) {
              context.read<PantryProvider>().removeItem(
                itemCategory,
                currentItem,
              );
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
        }
      );
    }
    
    return Column(
      children: [
        buildItemList(),
        Container(
          color: kColor1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                    color: kColor5,
                    borderRadius: BorderRadius.circular(4),
                ),
                child: MaterialButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            AddItemDialog(currentCategory: itemCategory)),
                    child: const Text('Add item')
                ),
              ),
            ],
          ),
        ),
        // Button that adds an item to a category
      ],
    );
  }
}
