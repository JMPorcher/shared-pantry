import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/pantry.dart';
import '../services/database_services.dart';

class PantryListProvider extends StatefulWidget {
  const PantryListProvider(
      {super.key, required this.pantryIds, required this.child});

  final Widget child;
  final List<String> pantryIds;

  @override
  State<PantryListProvider> createState() => _PantryListProviderState();
}

class _PantryListProviderState extends State<PantryListProvider> {

  List<Pantry> pantryList = [];
  late List<Stream<Pantry>> pantryStreams;
  late List<StreamSubscription<Pantry>> subscriptions;

  @override
  void initState() {
    super.initState();
    _fetchPantryList();
  }

  @override
  void didUpdateWidget(covariant PantryListProvider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.pantryIds != oldWidget.pantryIds) {
      // Call _fetchPantryList() only if pantryIds have changed
      _fetchPantryList();
    }
  }

  @override
  void dispose() {
    for (var subscription in subscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<List<Pantry>>(
      create: (BuildContext context) {
        return pantryList;
      },
      child: widget.child,
    );
  }

  Future<void> _fetchPantryList() async {
    pantryStreams = DatabaseService().streamPantryList(widget.pantryIds);
    subscriptions = pantryStreams.map((stream) {
      return stream.listen((pantry) {
        setState(() {
          // Check if the pantry already exists in the list
          final existingIndex = pantryList.indexWhere((p) => p.id == pantry.id);
          if (existingIndex != -1) {
            // If the pantry exists, update it
            pantryList[existingIndex] = pantry;
          } else {
            // If the pantry doesn't exist, add it to the list
            pantryList.add(pantry);
          }
        });
      });
    }).toList();
  }


  void addPantryWithTitle(String title, String? userid) {
    DatabaseService().addPantry(title, userid);
  }

  void editPantryTitle(String? pantryId, String newTitle) async {
    DatabaseService().editPantryTitle(pantryId, newTitle);
  }

  void removePantryFromDatabase(String? pantryId, String? userId) {
    DatabaseService().removePantryFromDatabase(pantryId, userId);
  }

  //Category functions, move to db
  void addCategory(String pantryId, String title) {
    DatabaseService().addCategory(pantryId, title);
  }

  void renameCategory(String pantryId, String categoryTitle, String newTitle) {
    DatabaseService().renameCategory(pantryId, categoryTitle, newTitle);
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

