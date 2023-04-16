import 'package:flutter/material.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/models/item_category.dart';

import '../models/item.dart';

class CategoryListProvider with ChangeNotifier {
  final List<ItemCategory> _categoriesList = [kTestCategory];
  List<ItemCategory> get categoriesList => _categoriesList;

  void printCategories() {
    var result = categoriesList.map((item) {
      return {"key": item.title};
    }).toList();
    print(result);
  }

  void addCategory(ItemCategory category) {
    _categoriesList.add(category);
    notifyListeners();
  }

  void removeCategoryAt(int index) {
    _categoriesList.removeAt(index);
    notifyListeners();
  }

  void toggleCategoryIsExpanded(int categoryIndex) {
    _categoriesList[categoryIndex].toggleExpanded();
    notifyListeners();
  }

  void addItem(int categoryIndex, Item item) {
    _categoriesList[categoryIndex].items.add(item);
    notifyListeners();
  }

  void removeItemAt(int categoryIndex, int index) {
    _categoriesList[categoryIndex].items.removeAt(index);
    notifyListeners();
  }

  void toggleItemAvailability(int categoryIndex, int index) {
    _categoriesList[categoryIndex].items[index].toggleAvailable();
    notifyListeners();
  }
}