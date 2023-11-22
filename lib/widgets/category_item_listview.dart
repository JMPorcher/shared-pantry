import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/models/item_category.dart';

import '../constants.dart';
import '../models/item.dart';
import '../providers/pantry_provider.dart';
import 'item_tile.dart';

class CategoryItemListView extends StatelessWidget {
  CategoryItemListView({required this.itemList, super.key});

  final ItemCategory itemList;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> fieldIsEmpty = ValueNotifier(true);
    ValueNotifier<String> itemTitleString = ValueNotifier('');
    void onTextChanged() {
      String newString = textEditingController.text;
      itemTitleString.value = newString;
      fieldIsEmpty.value = newString.isEmpty;
    }

    textEditingController.addListener(onTextChanged);

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
        leading: TextInputLine(textEditingController: textEditingController),
        trailing: AddItemButton(fieldIsEmpty: fieldIsEmpty, itemList: itemList, textEditingController: textEditingController),
      ),
    );
  }
}

class AddItemButton extends StatelessWidget {
  const AddItemButton({
    super.key,
    required this.fieldIsEmpty,
    required this.itemList,
    required this.textEditingController,
  });

  final ValueNotifier<bool> fieldIsEmpty;
  final ItemCategory itemList;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, top: 2, right: 12, bottom: 2),
      child: SizedBox(
          width: 30,
          height: 27,
          child: ValueListenableBuilder<bool>(
              valueListenable: fieldIsEmpty,
              builder:
                  (BuildContext context, bool fieldIsEmpty, Widget? child) {
                return ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: fieldIsEmpty
                          ? MaterialStateProperty.all(kColor11)
                          : MaterialStateProperty.all(kColor111),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.all(0))),
                  onPressed: () {
                    context.read<PantryProvider>().addItem(
                          itemList,
                          Item(textEditingController.text,
                              isAvailable: true),
                        );
                    textEditingController.clear();
                    FocusScope.of(context).unfocus();
                  },
                  child: const Icon(
                    Icons.add,
                    color: kColor1,
                  ),
                );
              })),
    );
  }
}

class TextInputLine extends StatelessWidget {
  const TextInputLine({
    super.key,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      height: 40,
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: TextField(
        onTapOutside: (_) {
          FocusScope.of(context).unfocus();
        },
        style: const TextStyle(fontSize: 14),
        textAlign: TextAlign.start,
        inputFormatters: [
          LengthLimitingTextInputFormatter(kItemLengthLimit)
        ],
        controller: textEditingController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          hintText: 'Add item',
          hintStyle: const TextStyle(color: Colors.black26, fontSize: 14),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kColor11, width: 2),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                width: 1.5, color: Colors.black.withOpacity(0.3)),
          ),
        ),
      ),
    );
  }
}
