import 'package:flutter/cupertino.dart';
import 'package:shared_pantry/models/item.dart';

class ItemCategory {
  ItemCategory({required this.title, required this.items});

  final String title;
  bool isExpanded = false;
  List<Item> items;

  void toggleExpanded() {
    isExpanded = !isExpanded;
  }
}