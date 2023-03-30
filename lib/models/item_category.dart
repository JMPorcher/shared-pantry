import 'package:shared_pantry/models/item.dart';

class Category {
  Category({
    required this.title,
    required this.isExpanded,
    required this.children,
    required this.id
  });

  final String title;
  bool isExpanded = false;
  List<Item> children;
  int id;

  void toggleExpanded() {
    isExpanded = !isExpanded;
  }
}