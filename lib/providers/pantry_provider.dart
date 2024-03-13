import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/pantry.dart';
import '../services/database_services.dart';

class PantryProvider extends ChangeNotifier {
  PantryProvider({required this.user}) {
    _initializeStreams();
  }

  final User? user;
  late StreamProvider<List<String>> _pantryIdStreamProvider;

  StreamProvider<List<String>> get pantryIdStreamProvider => _pantryIdStreamProvider;

  late List<Pantry> _pantries = [];

  List<Pantry> get pantries => _pantries;

  void _initializeStreams() {
    DatabaseService().streamPantrySubscriptionIds(user?.uid).listen((List<String> pantryIds) async {
      List<Future<Pantry>> futures = pantryIds.map((pantryId) async {
        DocumentSnapshot snapshot = await DatabaseService().pantryCollectionReference
            .doc(pantryId)
            .get();
        return DatabaseService().getPantryFromDocumentSnapshot(snapshot);
      }).toList();

      _pantries = await Future.wait(futures);
      notifyListeners();
    });
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
}