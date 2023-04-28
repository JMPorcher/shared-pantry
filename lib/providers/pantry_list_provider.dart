import 'package:flutter/material.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/models/item_category.dart';

import '../models/item.dart';
import '../models/pantry.dart';

class PantryProvider with ChangeNotifier {
  final List<ItemCategory> _categoriesList = [kTestCategory];
  List<ItemCategory> get categoriesList => _categoriesList;

  final List<Pantry> _pantriesList = [kTestPantry, kTestPantry2];
  List<Pantry> get pantriesList => _pantriesList;

  String currentPantryTitle = '';
  LoopPageController pageController = LoopPageController();

  void changeCurrentTitle(String onScreenTitle) {
    currentPantryTitle = onScreenTitle;
    notifyListeners();
  }

  int addPantryWithTitle(String title) {
    _pantriesList.add(Pantry([], pantryTitle: title));
    notifyListeners();
    return _pantriesList.length-1;
  }

  void editPantry(Pantry pantry, String newTitle) {
    pantry.editTitle(newTitle);
    notifyListeners();
  }


  //===========CATEGORY FUNCTIONS===========
  void addCategory(List<ItemCategory> itemCategoryList, ItemCategory itemCategory) {
    itemCategoryList.add(itemCategory);
    notifyListeners();
  }

  void removeCategory(List<ItemCategory> itemCategoryList, ItemCategory itemCategory) {
    itemCategoryList.remove(itemCategory);
    notifyListeners();
  }

  void editCategory(ItemCategory itemCategory, String newTitle) {
    itemCategory.changeTitle(newTitle);
    notifyListeners();
  }

  void toggleCategoryIsExpanded(List<ItemCategory> categoryList, ItemCategory itemCategory) {
    categoryList[categoryList.indexOf(itemCategory)].toggleExpanded();
    notifyListeners();
  }


  //===========ITEM FUNCTIONS===========
  void addItem(List<Item> itemList, Item item) {
    itemList.add(item);
    notifyListeners();
  }

  void removeItem(List<Item> itemList, Item item) {
    itemList.remove(item);
    notifyListeners();
  }

  void toggleItemAvailability(List<Item> itemList, Item item) {
    itemList[itemList.indexOf(item)].toggleAvailable();
    notifyListeners();
  }
}