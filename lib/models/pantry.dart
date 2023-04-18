import 'item_category.dart';

class Pantry {
  Pantry(this.categoryList, this.pantryIsShared);

  List<ItemCategory> categoryList = [];

  bool pantryIsShared;  // false = It's private
}