import 'package:flutter/material.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/models/item_category.dart';

import '../models/item.dart';
import '../models/pantry.dart';

class PantryProvider with ChangeNotifier {
  final List<ItemCategory> _categoriesList = [kTestCategory];

  List<ItemCategory> get categoriesList => _categoriesList;

  final List<Pantry> _pantriesList = [kTestPantry, kTestPantry2, kTestPantry3];

  List<Pantry> get pantriesList => _pantriesList;

  final LoopPageController pageController = LoopPageController();
  int activePantryIndex = 0;
  int activeScreenIndex = 0;

  //===========GENERAL FUNCTIONS===========

  void switchActiveScreen(newIndex) {
    activeScreenIndex = newIndex;
    notifyListeners();
  }

  // ===========PANTRY FUNCTIONS===========
  int addPantryWithTitle(String title) {
    _pantriesList.add(Pantry(title: title));
    notifyListeners();
    return _pantriesList.length - 1;
  }

  void renamePantry(Pantry pantry, String newTitle) {
    pantry.editTitle(newTitle);
    notifyListeners();
  }

  void removePantry(Pantry pantry) {
    _pantriesList.remove(pantry);
    notifyListeners();
  }

  void switchPantry(int newIndex) {
    activePantryIndex = newIndex;
    notifyListeners();
  }

  //===========CATEGORY FUNCTIONS===========
  void addCategory(
      List<ItemCategory> itemCategoryList, ItemCategory itemCategory) {
    itemCategoryList.add(itemCategory);
    notifyListeners();
  }

  void removeCategory(
      List<ItemCategory> itemCategoryList, ItemCategory itemCategory) {
    itemCategoryList.remove(itemCategory);
    notifyListeners();
  }

  void editCategoryName(ItemCategory itemCategory, String newTitle) {
    itemCategory.editTitle(newTitle);
    notifyListeners();
  }

  void toggleCategoryIsExpanded(
      List<ItemCategory> categoryList, ItemCategory itemCategory) {
    categoryList[categoryList.indexOf(itemCategory)].toggleExpanded();
    notifyListeners();
  }

  //===========ITEM FUNCTIONS===========
  void addItem(List<Item> itemCategory, Item item) {
    itemCategory.add(item);
    notifyListeners();
  }

  void removeItem(List<Item> itemList, Item item) {
    itemList.remove(item);
    notifyListeners();
  }

  void toggleItemAvailability(Item item) {
    item.toggleAvailable();
    notifyListeners();
  }
}
