

import 'package:cloud_firestore/cloud_firestore.dart';

class SharedPantryUser {
  SharedPantryUser(this.userName);

  String userName;
  //TODO String userId
  //TODO String eMail
  //TODO List<String> subscribedPantryHashes
  //TODO List<String> contacts
  //TODO Svg_image avatar = default_avatar_asset

  void editUserName(String newName) {
    userName = newName;
  }

  String? _userID;
  String? get userID => _userID;
  void setUserId(DocumentReference documentReference) {
    _userID = documentReference.id;
  }
  //TODO Analogously to pantryID use document ID of the User when it is created in firebase. Set the ID
}

