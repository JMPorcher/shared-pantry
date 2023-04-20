import 'package:flutter/material.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/models/item_category.dart';

import '../models/item.dart';
import '../models/pantry.dart';

class PantryListProvider with ChangeNotifier {
  final List<ItemCategory> _categoriesList = [kTestCategory];
  List<ItemCategory> get categoriesList => _categoriesList;

  final List<Pantry> _pantriesList = [kTestPantry, kTestPantry2];
  List<Pantry> get pantriesList => _pantriesList;

  void addCategory(ItemCategory category) {
    _categoriesList.add(category);
    notifyListeners();
  }

  void removeCategory(List<ItemCategory> itemCategoryList) {
    _categoriesList.remove(itemCategory);
    notifyListeners();
  }

  void editCategory(ItemCategory itemCategory, String newTitle) {
    itemCategory.changeTitle(newTitle);
    notifyListeners();
  }

  void toggleCategoryIsExpanded(int categoryIndex) {
    _categoriesList[categoryIndex].toggleExpanded();
    notifyListeners();
  }

  void addItem(List<Item> itemList, Item item) {
    itemList.add(item);
    notifyListeners();
  }

  void removeItemAt(int categoryIndex, int itemIndex) {
    _categoriesList[categoryIndex].items.removeAt(itemIndex);
    notifyListeners();
  }

  void toggleItemAvailability(int categoryIndex, int index) {
    _categoriesList[categoryIndex].items[index].toggleAvailable();
    notifyListeners();
  }
}