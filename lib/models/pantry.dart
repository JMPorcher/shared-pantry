import 'item.dart';
import 'item_category.dart';

class Pantry {
  Pantry(
      {required this.title,
        required this.pantryID,
        required this.founderID,
        List<ItemCategory>? categories}) : categories = categories ?? [];

      //TODO required String(userId) founder
      //TODO optional SvgPicture backgroundImage = default_image_asset
      //TODO List<String(userId), Item> activityHistory = []

  List<ItemCategory> categories = [];

  //Change later to add user as stated in to do above
  List<Item> activityHistory = [];
  final String? pantryID;
  final String? founderID;

  bool _selectedForShopping = true;
  bool get selectedForShopping => _selectedForShopping;
  void toggleSelectedForShopping(bool newValue) {
    _selectedForShopping = newValue;
  }

  String title;
  void editTitle(String newTitle) {
    title = newTitle;
  }

  bool _selectedForPushNotifications = true;
  bool get selectedForPushNotifications => _selectedForPushNotifications;
  void toggleSelectedForPushNotifications(bool newValue) {
    _selectedForPushNotifications = newValue;
  }
}