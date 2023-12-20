
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  UserProvider();



  late final String _userID;
   String get userID => _userID;

  Future<void> _initializeUser() async{
    //get ID asynchronously from FireBase authentication and save it to _userID
    //return _userID
  }
}


// JSON User Model
//  {
//    email: test@test.de,
//    user_name: "name",
//    subscribed_pantries:
//      [
      //  {
      //    pantry_id: "uniquePantryId",
      //    isSelectedForShopping: bool,
      //    isSelectedForPushNotifications: bool
      //  },
      //  {
      //    pantry_id: "uniquePantryId",
      //    isSelected: bool,
      //    isSelectedForPushNotifications: bool
      //  },
//      ]
// }