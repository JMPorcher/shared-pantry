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
}

