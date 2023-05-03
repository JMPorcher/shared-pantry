import 'item_category.dart';

class Pantry {
  Pantry(this.categoryList, {required this.pantryTitle});

  List<ItemCategory> categoryList = [];
  String pantryTitle;
  bool selected = true;

  void editTitle(String newTitle) {
    pantryTitle = newTitle;
  }



  // Pantry.private({});
  // Pantry.shared({});

  // const EdgeInsets.only({
  //   this.left = 0.0,
  //   this.top = 0.0,
  //   this.right = 0.0,
  //   this.bottom = 0.0,
  // });
}