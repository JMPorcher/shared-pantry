import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/models/item_category.dart';
import 'package:shared_pantry/providers/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/database_services.dart';
import 'app_state_provider.dart';

import '../models/item.dart';
import '../models/pantry.dart';

class PantryProvider extends StatelessWidget {
  final String pantryId;
  final Widget? child;

  const PantryProvider(
      {super.key,
        required this.pantryId,
        required this.child
      });

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Pantry>(
      create: (context) => DatabaseService().streamPantryDetails(pantryId),
      initialData:
          Pantry(moderatorIds: [], title: '', id: '', founderID: ''),
      //child: child,
    );
  }

// final AppStateProvider appStateProvider;
// final SpAuthProvider authProvider;
// final List<ItemCategory> _categoriesList = [kTestCategory];
//
// // ===========MOCK DATA===========
// List<ItemCategory> get categoriesList => _categoriesList;
//
//
// // ===========GENERAL FUNCTIONS===========
//
// void updateState() {
//   notifyListeners();
// }
//
// // ===========PANTRY FUNCTIONS===========
//
//
//
// void renamePantry(Pantry pantry, String newTitle) {
//   pantry.editTitle(newTitle);
//   notifyListeners();
// }
//
// void removePantry(Pantry pantry) {
//   // _pantriesList.remove(pantry);
//   // notifyListeners();
// }
//
// void switchPantry(int newIndex) async {
//   appStateProvider.newPantryIndex = newIndex;
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   sharedPreferences.setInt('Last shown pantry', newIndex <= 2 ? newIndex : 2);
//   notifyListeners();
// }
//
// void togglePantrySelectedForShopping(Pantry pantry, bool newValue) {
//   pantry.toggleSelectedForShopping(newValue);
//   notifyListeners();
// }
//
// void toggleSelectedForPushNotifications(Pantry pantry, bool newValue) {
//   pantry.toggleSelectedForPushNotifications(newValue);
//   notifyListeners();
// }
//
// //TODO Remove this again later. Just for test purposes
// void removePantryByIndex(int index) {
//   // pantriesList.removeAt(index);
//   // notifyListeners();
// }
//
// //===========CATEGORY FUNCTIONS===========
// void addCategory(
//     List<ItemCategory> itemCategoryList, ItemCategory itemCategory) {
//   itemCategoryList.add(itemCategory);
//   notifyListeners();
// }
//
// void removeCategory(
//     List<ItemCategory> itemCategoryList, ItemCategory itemCategory) {
//   itemCategoryList.remove(itemCategory);
//   notifyListeners();
// }
//
// void editCategoryName(ItemCategory itemCategory, String newTitle) {
//   itemCategory.editTitle(newTitle);
//   notifyListeners();
// }
//
// void toggleCategoryIsExpanded(
//     List<ItemCategory> categoryList, ItemCategory itemCategory) {
//   categoryList[categoryList.indexOf(itemCategory)].toggleExpanded();
//   notifyListeners();
// }
//
// //===========ITEM FUNCTIONS===========
// void addItem(ItemCategory itemCategory, Item item) {
//   itemCategory.add(item);
//   notifyListeners();
// }
//
// void removeItem(ItemCategory itemCategory, Item item) {
//   itemCategory.remove(item);
//   notifyListeners();
// }
//
// void toggleItemAvailability(Item item) {
//   item.toggleAvailable();
//   notifyListeners();
// }
}
