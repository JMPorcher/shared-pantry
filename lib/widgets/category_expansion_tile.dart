import 'package:flutter/material.dart';
import 'package:shared_pantry/widgets/text_input_fields.dart';

import '../constants.dart';
import '../dialogs/edit_category_dialog.dart';
import '../models/item.dart';
import '../models/item_category.dart';
import '../models/pantry.dart';
import 'item_tile.dart';

class CategoryExpansionTile extends StatelessWidget {
  const CategoryExpansionTile(this.pantry,
      this.currentCategory,
      {super.key}
  );

  final ItemCategory currentCategory;
  final Pantry pantry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GestureDetector(
          onLongPress: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => EditCategoryDialog(
                pantry,
                itemCategory: currentCategory,
              ),
            );
          },
          child: Card(
            color: kColor1,
            margin: const EdgeInsets.only(bottom: 10),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.antiAlias,
            child: ExpansionTile(
              initiallyExpanded:
              currentCategory.isExpanded,
              onExpansionChanged: (_) {
                currentCategory
                    .toggleExpanded();
              },
              title: CenteredTitleText(currentCategory),
              backgroundColor: kColor11,
              collapsedBackgroundColor: kColor11,
              children: [
                CategoryItemListView(itemList: currentCategory)
              ],
            ),
          ),
        ),
    );
  }
}

class CenteredTitleText extends StatelessWidget {
  const CenteredTitleText(this.currentCategory, {
    super.key});

  final ItemCategory currentCategory;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
          currentCategory.title,
          style: const TextStyle(
            fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w500),
        ));
  }
}

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
      toggleSwitch: (_) => {}, //context.read<PantryProvider>().toggleItemAvailability(currentItem),
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
        trailing: null
          //TODO Repair AddItemTile
        // AddItemButton(
        //   fieldIsEmpty: fieldIsEmpty,
        //   onPressed: () {
        //     context.read<PantryProvider>().addItem(
        //       itemList,
        //       Item(textEditingController.text,
        //           isAvailable: true),
        //     );
        //     textEditingController.clear();
        //     FocusScope.of(context).unfocus();
        //   },),
      ),
    );
  }
}