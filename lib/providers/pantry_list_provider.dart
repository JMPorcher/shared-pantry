import 'dart:async';

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
    // TODO: implement initState
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
    //pantryList.clear();
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
}

