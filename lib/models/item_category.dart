import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_pantry/models/item.dart';
import 'package:shared_pantry/services/database_services.dart';

class ItemCategory {
  ItemCategory(this.title, {List<Item>? items}) : items = items ?? [];
  //TODO When test data is not needed anymore, remove items argument altogether

  ItemCategory.fromSnapshot(QueryDocumentSnapshot snapshot)
    : title = snapshot['title'],
      items = snapshot['items'] ?? [];

  String title;
  bool isExpanded = false;
  List<Item> items;

//TODO Change add item/delete item occurrences in UI

  void add(pantryId, categoryTitle, itemTitle) {
    //items.add(item);
    DatabaseService().addItem(pantryId, categoryTitle, itemTitle);

  }

  void remove(pantryId, categoryTitle, itemTitle) {
    //items.remove(item);
    DatabaseService().deleteItem(pantryId, categoryTitle, itemTitle);
  }

  void toggleExpanded() {
    isExpanded = !isExpanded;
  }

  void editTitle(String newTitle) {
    title = newTitle;
  }
}