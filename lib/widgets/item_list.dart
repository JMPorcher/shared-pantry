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
            return Dismissible(
              onDismissed: (direction){context.read<ItemListProvider>().removeItemAt(index);},
              key: UniqueKey(),
              child: ItemTile(
                  itemList[index].title,
                  itemList[index].isAvailable,
                  toggleSwitch: (_) { context.read<ItemListProvider>().toggleItemAvailability(index);}
              ),
            );
          }
      ),
    );
  }
}

class ItemListProvider with ChangeNotifier {
  final List<Item> _itemList = [
    Item('Bread', false),
    Item('Enriched Uranium', false),
    Item('Test from office', true),
  ];
  List<Item> get itemList => _itemList;

  void addItem(Item item) {
    _itemList.add(item);
    notifyListeners();
  }

  void removeItemAt(int index) {
    _itemList.removeAt(index);
    notifyListeners();
  }

  void toggleItemAvailability(int index) {
    _itemList[index].toggleAvailable();
    notifyListeners();
  }
}