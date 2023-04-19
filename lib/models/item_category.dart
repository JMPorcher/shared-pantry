import 'package:shared_pantry/models/item.dart';

class ItemCategory {
  ItemCategory({required this.title, required this.items});

  String title;
  bool isExpanded = false;
  List<Item> items;

  void toggleExpanded() {
    isExpanded = !isExpanded;
  }

  void changeTitle(String newTitle) {
    title = newTitle;
  }
}