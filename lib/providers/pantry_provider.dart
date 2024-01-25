import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/models/item_category.dart';
import 'package:shared_pantry/providers/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_state_provider.dart';

import '../models/item.dart';
import '../models/pantry.dart';

//TODO Think about if this makes sense as a provider. Does it cover a scenario where a user has several pantries?

class PantryProvider with ChangeNotifier {
  PantryProvider(this.appStateProvider, this.authProvider);

  final AppStateProvider appStateProvider;
  final SpAuthProvider authProvider;
  final List<ItemCategory> _categoriesList = [kTestCategory];

  // ===========MOCK DATA===========
  List<ItemCategory> get categoriesList => _categoriesList;

  final List<Pantry> _pantriesList = [
    kTestPantry, kTestPantry2, kTestPantry3
  ];

  List<Pantry> get pantriesList => _pantriesList;

  final db = FirebaseFirestore.instance;

  // ===========GENERAL FUNCTIONS===========

  void updateData() async {
    final User? user = authProvider.user;
    print('User ID: ${user?.uid}');
    final userDocumentRef = db.collection('users').doc(user?.uid);

    userDocumentRef.get().then((docSnapshot) {
      if (docSnapshot.exists) {
        // Get the data as a Map
        Map<String, dynamic>? userData = docSnapshot.data();

        // Check if the 'subscribed_pantries' field exists and is a List
        if (userData!.containsKey('subscribed_pantries') && userData['subscribed_pantries'] is List) {
          // Cast the 'subscribed_pantries' field to a List
          List<dynamic> pantries = userData['subscribed_pantries'];

          // Loop through each pantry in the list and print its value
          for (var pantry in pantries) {
            print(pantry); // Print each pantry
          }
        } else {
          print('No subscribed pantries found');
        }
      } else {
        print('Document does not exist');
      }
    }).catchError((error) {
      print('Error retrieving document: $error');
    });



    //final userDocumentRef = db.collection('users').doc(user?.uid).collection('subscribed_pantries');
    // userDocumentRef.get().then(
    //         (snapshot) {
    //           //TODO Why are the subscribed_pantries screenshots empty?
    //           // for (var pantrySnapshot in snapshot.docs) {
    //           //   print('${pantrySnapshot..} => ${pantrySnapshot.data()}');
    //           // }
    //         },
    // );

    //Retrieve ID list  subscribed_pantries from user.uid
    //Loop through pantry IDs, retrieve every pantry through its ID and create a Pantry object from it

    //updateState();
  }

  void updateState() {
    notifyListeners();
  }

  // ===========PANTRY FUNCTIONS===========
  Future addPantryWithTitle(String title) async {
    final User? user = await authProvider.getCurrentUser();

    DocumentReference<Map<String, dynamic>> pantryDocumentReference = await db.collection('pantries').add({
      'title': title,
      'founder' : user?.uid,
      'users' : [user?.uid],
      'moderators': [user?.uid],

      //TODO Load pantry from database back to UI

      //TODO Should add with background image
      //TODO Once assistant is created: Add categories and items
    });
    
    DocumentReference<Map<String, dynamic>> userDocumentReference = db.collection('users')
        .doc(user?.uid);
    userDocumentReference.update({
      'subscribed_pantries' : FieldValue.arrayUnion([pantryDocumentReference.id])}
    );

    //TODO Possibly remove local adding of pantry
    //_pantriesList.add(Pantry(title: title, founderID: user?.uid, pantryID: pantryId));
    appStateProvider.switchActiveScreen(1);
    notifyListeners();
  }

  void renamePantry(Pantry pantry, String newTitle) {
    pantry.editTitle(newTitle);
    notifyListeners();
  }

  void removePantry(Pantry pantry) {
    _pantriesList.remove(pantry);
    notifyListeners();
  }

  void switchPantry(int newIndex) async {
    appStateProvider.newPantryIndex = newIndex;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('Last shown pantry', newIndex <= 2 ? newIndex : 2);
    notifyListeners();
  }

  void togglePantrySelectedForShopping(Pantry pantry, bool newValue){
    pantry.toggleSelectedForShopping(newValue);
    notifyListeners();
  }

  void toggleSelectedForPushNotifications(Pantry pantry, bool newValue){
    pantry.toggleSelectedForPushNotifications(newValue);
    notifyListeners();
  }

  //TODO Remove this again later. Just for test purposes
  void removePantryByIndex(int index) {
    pantriesList.removeAt(index);
    notifyListeners();
  }

  //===========CATEGORY FUNCTIONS===========
  void addCategory(
      List<ItemCategory> itemCategoryList, ItemCategory itemCategory) {
    itemCategoryList.add(itemCategory);
    notifyListeners();
  }

  void removeCategory(
      List<ItemCategory> itemCategoryList, ItemCategory itemCategory) {
    itemCategoryList.remove(itemCategory);
    notifyListeners();
  }

  void editCategoryName(ItemCategory itemCategory, String newTitle) {
    itemCategory.editTitle(newTitle);
    notifyListeners();
  }

  void toggleCategoryIsExpanded(
      List<ItemCategory> categoryList, ItemCategory itemCategory) {
    categoryList[categoryList.indexOf(itemCategory)].toggleExpanded();
    notifyListeners();
  }

  //===========ITEM FUNCTIONS===========
  void addItem(ItemCategory itemCategory, Item item) {
    itemCategory.add(item);
    notifyListeners();
  }

  void removeItem(ItemCategory itemCategory, Item item) {
    itemCategory.remove(item);
    notifyListeners();
  }

  void toggleItemAvailability(Item item) {
    item.toggleAvailable();
    notifyListeners();
  }
}
