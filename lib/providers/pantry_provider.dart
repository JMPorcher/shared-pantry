import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/models/item_category.dart';
import 'package:shared_pantry/providers/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_state_provider.dart';

import '../models/item.dart';
import '../models/pantry.dart';

class PantryProvider with ChangeNotifier {
  PantryProvider(this.appStateProvider, this.authProvider);

  final AppStateProvider appStateProvider;
  final SpAuthProvider authProvider;
  final List<ItemCategory> _categoriesList = [kTestCategory];

  // ===========MOCK DATA===========
  List<ItemCategory> get categoriesList => _categoriesList;

  List<Pantry> _pantriesList = [];

  List<Pantry> get pantriesList => _pantriesList;

  final db = FirebaseFirestore.instance;

  // ===========GENERAL FUNCTIONS===========

  void updateData() async {
    final User? user = authProvider.user;

    List<Pantry> userPantries = [];
    List<dynamic> ids = await getUsersPantryIds(user?.uid);
    if (ids.isNotEmpty) {
      List<dynamic> pantryObjects = await generatePantryObjects(ids);
      userPantries = pantryObjects.cast<Pantry>();
    }
    _pantriesList = userPantries;
    //TODO Actually turn the pantriesList into UI elements
  }

  Future<List<dynamic>> getUsersPantryIds(String? uid) async {
    final userDocumentRef = db.collection('users').doc(uid);
    List<dynamic> pantryIds = [];

    try {
      var docSnapshot = await userDocumentRef.get();
      if (docSnapshot.exists) {
        Map<String, dynamic>? userData = docSnapshot.data();
        if (userData!.containsKey('subscribed_pantries') &&
            userData['subscribed_pantries'] is List) {
          pantryIds.addAll(userData['subscribed_pantries']);
          print('Length pantryIds ${pantryIds.length}');
        } else {
          print('No subscribed pantries found');
        }
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print(e);

    }
    //TODO If any check fails, display snackbar to user about error. Maybe send info to admin (which is me)
    return pantryIds;
  }

  Future<List<Pantry>> generatePantryObjects(List<dynamic> ids) async {
    List<Pantry> pantryObjects = [];
    for (var id in ids) {
      final pantryDocumentRef = db.collection('pantries').doc(id);
      var pantrySnapshot = await pantryDocumentRef.get();

      if (pantrySnapshot.exists) {
        Map<String, dynamic>? pantryData = pantrySnapshot.data();
        pantryObjects.add(Pantry(
          title: pantryData?['title'] ?? '(no title found)',
          founderID: pantryData?['founder'] ?? '(no founder found)',
          pantryID: id,
          moderatorIds: pantryData?['moderators'] ?? ['(no title found)'],
        ));
      }
    }
    return pantryObjects;
  }

  void updateState() {
    notifyListeners();
  }

  // ===========PANTRY FUNCTIONS===========
  Future addPantryWithTitle(String title) async {
    final User? user = await authProvider.getCurrentUser();

    DocumentReference<Map<String, dynamic>> pantryDocumentReference =
        await db.collection('pantries').add({
      'title': title,
      'founder': user?.uid,
      'users': [user?.uid],
      'moderators': [user?.uid],

      //TODO Load pantry from database back to UI

      //TODO Should add with background image
      //TODO Once assistant is created: Add categories and items
    });

    DocumentReference<Map<String, dynamic>> userDocumentReference =
        db.collection('users').doc(user?.uid);
    userDocumentReference.update({
      'subscribed_pantries': FieldValue.arrayUnion([pantryDocumentReference.id])
    });

    //TODO Possibly remove local adding of pantry
    //_pantriesList.add(Pantry(title: title, founderID: user?.uid, pantryID: pantryId));
    appStateProvider.switchActiveScreen(1);
    notifyListeners();
  }

  void renamePantry(Pantry pantry, String newTitle) {
    pantry.editTitle(newTitle);
    notifyListeners();
  }

  void removePantry(Pantry pantry) {
    _pantriesList.remove(pantry);
    notifyListeners();
  }

  void switchPantry(int newIndex) async {
    appStateProvider.newPantryIndex = newIndex;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('Last shown pantry', newIndex <= 2 ? newIndex : 2);
    notifyListeners();
  }

  void togglePantrySelectedForShopping(Pantry pantry, bool newValue) {
    pantry.toggleSelectedForShopping(newValue);
    notifyListeners();
  }

  void toggleSelectedForPushNotifications(Pantry pantry, bool newValue) {
    pantry.toggleSelectedForPushNotifications(newValue);
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
  void addItem(ItemCategory itemCategory, Item item) {
    itemCategory.add(item);
    notifyListeners();
  }

  void removeItem(ItemCategory itemCategory, Item item) {
    itemCategory.remove(item);
    notifyListeners();
  }

  void toggleItemAvailability(Item item) {
    item.toggleAvailable();
    notifyListeners();
  }
}
