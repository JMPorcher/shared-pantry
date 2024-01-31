import 'item.dart';
import 'item_category.dart';

class Pantry {
  Pantry(
      {required this.moderatorIds, required this.title,
        required this.pantryID,
        required this.founderID,
        List<ItemCategory>? categories}) : categories = categories ?? [];

      //TODO optional SvgPicture backgroundImage = default_image_asset
      //TODO List<String(userId), Item> activityHistory = []

  //TODO replace with constructor parameter once pantry creation assistant is there
  List<ItemCategory> categories = [];

  List<Item> activityHistory = [];
  final String? pantryID;
  final String? founderID;
  final List<String?> moderatorIds;

  bool _selectedForShopping = true;
  bool get selectedForShopping => _selectedForShopping;
  void toggleSelectedForShopping(bool newValue) {
    _selectedForShopping = newValue;
  }

  //TODO Make final once database function is there
  String title;

  void editTitle(String newTitle) {
    title = newTitle;
    //TODO update Title in database
  }


  // Local functionality
  bool _selectedForPushNotifications = true;
  bool get selectedForPushNotifications => _selectedForPushNotifications;
  void toggleSelectedForPushNotifications(bool newValue) {
    _selectedForPushNotifications = newValue;
  }
}