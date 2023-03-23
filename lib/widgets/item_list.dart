import 'package:flutter/material.dart';
import 'package:shared_pantry/widgets/ItemTile.dart';
import '../models/item.dart';
import 'package:provider/provider.dart';

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {

  @override
  Widget build(BuildContext context) {
    List<Item> itemList = context.watch<ItemListProvider>().itemList;
    return Expanded(
      child: ListView.builder(
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            return ItemTile(
                itemList[index].title,
                itemList[index].isAvailable,
                toggleSwitch: (_) => itemList[index].toggleAvailable());
          }
      ),
    );
  }
}

class ItemListProvider with ChangeNotifier {
  final List<Item> _itemList = [
    Item('Bread', false),
    Item('Boyyy', false),
  ];
  List<Item> get itemList => _itemList;

  void addItem(Item item) {
    itemList.add(item);
    notifyListeners();
  }

  void removeItem(Item item) {
    itemList.remove(item);
    notifyListeners();
  }

  void toggleItemAvailability(int index) {
    itemList[index].toggleAvailable();
    notifyListeners();
  }
}