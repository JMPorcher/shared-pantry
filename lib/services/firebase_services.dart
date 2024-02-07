import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {

  final db = FirebaseFirestore.instance;

  Future addPantryWithTitle(dynamic uid, String title) async {
    await db.collection('pantries').add({
      'title': title,
      'founder': uid,
      'users': [uid],
      'moderators': [uid],

      //TODO Should add with background image
      //TODO Once assistant is created: Add categories and items
    });
  }


}