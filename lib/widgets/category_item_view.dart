import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/models/item_category.dart';

import '../constants.dart';
import '../models/item.dart';
import '../providers/pantry_provider.dart';
import 'item_tile.dart';

class CategoryItemView extends StatefulWidget {
  const CategoryItemView({required this.itemList, super.key});

  final ItemCategory itemList;

  @override
  State<CategoryItemView> createState() => _CategoryItemViewState();
}

class _CategoryItemViewState extends State<CategoryItemView> {
  final TextEditingController textEditingController = TextEditingController();
  final ValueNotifier<String> itemTitleValueNotifier =
      ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    textEditingController.text = itemTitleValueNotifier.value;
    ValueNotifier<bool> fieldIsEmpty = ValueNotifier(true);
    final ItemCategory itemList = widget.itemList;

    return Column(
      children: [
        for (var item in widget.itemList.items) buildItemTile(item),
        buildAddItemTile(fieldIsEmpty, context, itemList),
      ],
    );
  }

  Dismissible buildItemTile(Item currentItem) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        context.read<PantryProvider>().removeItem(
          widget.itemList,
          currentItem,
        );
      },
      key: UniqueKey(),
      child: ItemTile(
        toggleSwitch: (_) =>
            context
                .read<PantryProvider>()
                .toggleItemAvailability(currentItem),
        itemTitle: currentItem.title,
        isAvailable: currentItem.isAvailable,
      ),
    );
  }

  Container buildAddItemTile(ValueNotifier<bool> fieldIsEmpty, BuildContext context, ItemCategory itemList) {
    return Container(
        color: kColor1,
        child: ListTile(
          dense: true,
          leading: Container(
            width: 230,
            height: 40,
            padding: const EdgeInsets.only(top: 4, bottom: 4),
            child: TextField(
              onChanged: (_) {
                if (textEditingController.text.isNotEmpty) {
                  fieldIsEmpty.value = false;
                } else {
                  fieldIsEmpty.value = true;
                }
              },
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
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                hintText: 'Add item',
                hintStyle:
                    const TextStyle(color: Colors.black26, fontSize: 14),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kColor11,
                        width: 2),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.5,
                    color: Colors.black.withOpacity(0.3)
                  ),
                ),
              ),
            ),
          ),
          trailing: Padding(
            padding:
                const EdgeInsets.only(left: 2, top: 2, right: 12, bottom: 2),
            child: SizedBox(
              width: 30,
              height: 27,
              child: ValueListenableBuilder(
                valueListenable: fieldIsEmpty,
                builder: (BuildContext context, bool value, Widget? child) {
                  return ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: fieldIsEmpty.value
                            ? MaterialStateProperty.all(kColor11)
                            : MaterialStateProperty.all(kColor111),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(0))),
                    onPressed: () => setState(() {
                      itemList.items.add(Item(textEditingController.text,
                          isAvailable: true));
                      FocusScope.of(context).unfocus();
                    }),
                    child: const Icon(
                      Icons.add,
                      color: kColor1,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
  }
}
