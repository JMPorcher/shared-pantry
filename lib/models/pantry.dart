import 'item_category.dart';

class Pantry {
  Pantry(
      {required this.title,
        List<ItemCategory>? categories,}) : categories = categories ?? [];
      //TODO required String pantryId;
      //TODO required String(userId) founder
      //TODO optional SvgPicture backgroundImage = default_image_asset

  //TODO: Add ID generator for pantries

  List<ItemCategory> categories = [];
  String title;
  //TODO List<String(userId), Item> activityHistory = []

  bool _selectedForShopping = true;
  bool get selectedForShopping => _selectedForShopping;
  void toggleSelectedForShopping(bool newValue) {
    _selectedForShopping = newValue;
  }

  void editTitle(String newTitle) {
    title = newTitle;
  }

  bool _selectedForPushNotifications = true;
  bool get selectedForPushNotifications => _selectedForPushNotifications;
  void toggleSelectedForPushNotifications(bool newValue) {
    _selectedForPushNotifications = newValue;
  }

}