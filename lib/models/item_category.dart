import 'package:shared_pantry/models/item.dart';

class ItemCategory {
  ItemCategory(this.title, {List<Item>? items}) : items = items ?? [];
  //TODO When test data is not needed anymore, remove items argument altogether

  ItemCategory.fromJson(Map<String, dynamic>? parsedJson)
    : title = parsedJson?['title'],
      items = parsedJson?['items'];

  String title;
  bool isExpanded = false;
  List<Item> items;


  void add(Item item) {
    items.add(item);
  }

  void remove(Item item) {
    items.remove(item);
  }

  void toggleExpanded() {
    isExpanded = !isExpanded;
  }

  void editTitle(String newTitle) {
    title = newTitle;
  }
}