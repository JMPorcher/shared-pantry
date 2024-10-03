import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_pantry/models/item_category.dart';

import '../models/pantry.dart';
import '../services/database_services.dart';

class PantryProvider extends ChangeNotifier {
  PantryProvider({required this.user}) {
    _initializeStreams();
  }

  final User? user;
  late StreamSubscription<List<String>> _pantryIdSubscription;
  late List<Pantry> _pantries = [];

  List<Pantry> get pantries => _pantries;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _initializeStreams() {
    _pantryIdSubscription = DatabaseService().streamPantrySubscriptionIds(user?.uid).listen((List<String> pantryIds) async {
      List<Pantry> newPantries = [];

      for (String pantryId in pantryIds) {
        DocumentSnapshot pantrySnapshot = await DatabaseService().pantryCollectionReference.doc(pantryId).get();
        Pantry pantry = DatabaseService().getPantryFromDocumentSnapshot(pantrySnapshot);

        // Listen for changes to categories and items inside the pantry
        _listenToCategoryChanges(pantry);
        _listenToItemChanges(pantryId);

        newPantries.add(pantry);
      }

      _pantries = newPantries;
      for (Pantry pantry in _pantries) print(pantry.title);
      notifyListeners();
    });
  }

  void _listenToCategoryChanges(Pantry pantry) {
    DatabaseService()
        .pantryCollectionReference
        .doc(pantry.id)
        .collection('categories')
        .snapshots()
        .listen((snapshot) {
            List<ItemCategory> categories = snapshot
                .docs
                .map((categorySnapshot) => ItemCategory.fromSnapshot(categorySnapshot)).toList();
            pantry.categories = categories;
            notifyListeners();
        });
  }

  void _listenToItemChanges(String pantryId) {
    // Stream items collection inside each category and handle changes
    // Example:
    // DatabaseService().pantryCollectionReference.doc(pantryId).collection('categories').snapshots().listen((snapshot) {
    //   snapshot.docs.forEach((categoryDoc) {
    //     categoryDoc.reference.collection('items').snapshots().listen((itemSnapshot) {
    //       // Handle item changes
    //     });
    //   });
    // });
  }

  void addPantry(String title, String? userid) {
    DatabaseService().addPantry(title, userid);
  }

  void editPantryTitle(String? pantryId, String newTitle) {
    DatabaseService().renamePantry(pantryId, newTitle);
    notifyListeners();
  }

  void removePantryFromDatabase(String? pantryId, String? userId) {
    DatabaseService().removePantryFromDatabase(pantryId, userId);
  }

  //Category functions, move to db
  void addCategory(String? pantryId, String title) {
    DatabaseService().addCategory(pantryId, title);
  }

  void renameCategory(
      {required String? pantryId, required String oldTitle, required String newTitle}) {
    DatabaseService().renameCategory(pantryId, oldTitle, newTitle);
  }

  void deleteCategory(String pantryId, String categoryId) {
    DatabaseService().deleteCategory(pantryId, categoryId);
  }

  //Item functions
  void addItem(String pantryId, String categoryTitle, String itemTitle) {
    DatabaseService().addItem(pantryId, categoryTitle, itemTitle);
  }

  void switchItemAvailability(String pantryId, String categoryTitle, String itemTitle) {
    DatabaseService().switchItemAvailability(pantryId, categoryTitle, itemTitle);
  }

  void deleteItem(String pantryId, String categoryId, String itemId) {
    DatabaseService().deleteItem(pantryId, categoryId, itemId);
  }

  void deleteUser(){
    DatabaseService().deleteUser(user);
  }
}