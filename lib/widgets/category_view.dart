import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/models/item_category.dart';

import '../constants.dart';
import '../models/item.dart';
import '../providers/pantry_provider.dart';
import 'item_tile.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({required this.itemList, super.key});

  final ItemCategory itemList;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
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
        for (var currentItem in widget.itemList.items)
          Dismissible(
            direction: DismissDirection.endToStart,
            onDismissed: (_) {
              context.read<PantryProvider>().removeItem(
                widget.itemList,
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
          ),
        Container(
          color: kColor1,
          child: ListTile(
            dense: true,
            leading: Container(
              width: 230,
              height: 40,
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: TextField(
                onChanged: (_) {
                  if (textEditingController.text.isNotEmpty) {
                    fieldIsEmpty.value = false;
                  } else {
                    fieldIsEmpty.value = true;
                  }
                },
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.start,
                inputFormatters: [LengthLimitingTextInputFormatter(90)],
                controller: textEditingController,
                decoration: const InputDecoration(
                  hintText: '(Add item)',
                  hintStyle: TextStyle(color: Colors.black26, fontSize: 14),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12, width: 3)
                  ),
                ),
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(left: 2.0, top: 2, right: 12, bottom: 2),
              child: SizedBox(
                width: 30,
                height: 30,
                child: ValueListenableBuilder(
                  valueListenable: fieldIsEmpty,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return ElevatedButton(
                        style:
                        ButtonStyle(
                            backgroundColor: fieldIsEmpty.value ? MaterialStateProperty.all(kColor111) : MaterialStateProperty.all(kColor51),
                            padding: MaterialStateProperty.all(const EdgeInsets.all(0))),
                        onPressed: () => setState(() {
                          itemList.items.add(Item(textEditingController.text, isAvailable: true));
                        }),
                        child: const Icon(
                          Icons.add,
                          color: kColor1,
                        ));
                  },

                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}