import 'package:flutter/material.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/models/item_category.dart';

import '../models/item.dart';
import '../models/pantry.dart';

class PantryProvider with ChangeNotifier {
  final List<ItemCategory> _categoriesList = [kTestCategory];
  List<ItemCategory> get categoriesList => _categoriesList;

  final List<Pantry> _pantriesList = [kTestPantry, kTestPantry2, kTestPantry3];
  List<Pantry> get pantriesList => _pantriesList;

  int _selectedPantryIndex = 0;
  int get selectedPantryIndex => _selectedPantryIndex;
  int shownScreenIndex = 0; //TODO Move shown screen index to responsibility of MainScreen

  //===========GENERAL FUNCTIONS===========

  void switchActiveScreen(newIndex) {
    shownScreenIndex = newIndex;
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
    _selectedPantryIndex = newIndex;
    notifyListeners();
  }

  void switchPantrySelectedForShopping(Pantry pantry, bool newValue){
    pantry.toggleSelectedForShopping(newValue);
    notifyListeners();
  }

  //TODO Remove this again later. Just for test purposes
  void removePantryByIndex(int index) {
    pantriesList.removeAt(index);
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
