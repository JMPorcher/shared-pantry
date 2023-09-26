import 'package:shared_pantry/models/item.dart';

class ItemCategory {
  ItemCategory(this.title, {List<Item>? items}) : items = items ?? [];
  //TODO Remove items argument altogether

  String title;
  bool isExpanded = false;
  List<Item> items;

  void toggleExpanded() {
    isExpanded = !isExpanded;
  }

  void editTitle(String newTitle) {
    title = newTitle;
  }
}