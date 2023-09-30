import 'item_category.dart';

class Pantry {
  Pantry(
      {required this.title,
        List<ItemCategory>? categories,}) : categories = categories ?? [];
      //TODO make categories required once testing phase is over
      //TODO required String pantryId;
      //TODO required String(userId) founder
      //TODO optional SvgPicture backgroundImage = default_image_asset

  //TODO: Add ID generator for pantries somewhere

  List<ItemCategory> categories = [];
  String title;
  //TODO List<String(userId), Item> activityHistory = []

  bool selectedForShopping = true;
  // void toggleSelected() {
  //   selected = !selected;
  // }

  void editTitle(String newTitle) {
    title = newTitle;
  }



}