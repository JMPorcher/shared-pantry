import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/models/item_category.dart';
import 'package:shared_pantry/widgets/text_input_fields.dart';

import '../constants.dart';
import '../models/item.dart';
import '../providers/pantry_provider.dart';
import 'buttons.dart';
import 'item_tile.dart';

class CategoryItemListView extends StatelessWidget {
  CategoryItemListView({required this.itemList, super.key});

  final ItemCategory itemList;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> fieldIsEmpty = ValueNotifier(true);

    return Column(
      children: [
        for (var item in itemList.items) buildItemTile(item, context),
        AddItemTile(
            textEditingController: textEditingController,
            fieldIsEmpty: fieldIsEmpty,
            itemList: itemList)
        //buildAddItemTile(fieldIsEmpty, context, textEditingController, itemTitleString)
      ],
    );
  }

  ItemTile buildItemTile(Item currentItem, BuildContext context) {
    return ItemTile(
      toggleSwitch: (_) =>
          context.read<PantryProvider>().toggleItemAvailability(currentItem),
      itemTitle: currentItem.title,
      isAvailable: currentItem.isAvailable,
    );
  }
}

class AddItemTile extends StatelessWidget {
  const AddItemTile({
    super.key,
    required this.textEditingController,
    required this.fieldIsEmpty,
    required this.itemList,
  });

  final TextEditingController textEditingController;
  final ValueNotifier<bool> fieldIsEmpty;
  final ItemCategory itemList;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColor1,
      child: ListTile(
        dense: true,
        leading: ItemTitleInputLine(
            textEditingController: textEditingController, fieldIsEmpty: fieldIsEmpty,),
        trailing: AddItemButton(
            fieldIsEmpty: fieldIsEmpty,
            onPressed: () {
              context.read<PantryProvider>().addItem(
                itemList,
                Item(textEditingController.text,
                    isAvailable: true),
              );
              textEditingController.clear();
              FocusScope.of(context).unfocus();
            },),
      ),
    );
  }
}


