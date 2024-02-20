import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/pantry.dart';

class DatabaseService {
  DatabaseService(this.uid) {
    userDataReference = FirebaseFirestore.instance.collection('users').doc(uid);
    pantryCollectionReference = FirebaseFirestore.instance.collection('pantries');
  }

  final String uid;
  late final DocumentReference userDataReference;
  late final CollectionReference<Map<String, dynamic>>  pantryCollectionReference;


  Stream<List<String>> streamSubscribedPantries() {
    return userDataReference
        .collection('subscribed_pantries')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => doc['pantry_id'] as String)
        .toList());
  }

  Stream<Pantry> streamPantryDetails(String pantryId) {
    return pantryCollectionReference
        .doc(pantryId)
        .snapshots()
        .map((snapshot) => _getPantryFromDocumentSnapshot(snapshot));
  }

  Pantry _getPantryFromDocumentSnapshot(DocumentSnapshot doc) {
         return Pantry(
             pantryID: doc.id,
             title: doc['title'],
             moderatorIds: doc['moderators'],
             founderID: doc['founder']
           );
  }

  Stream<List<Pantry>> get pantryData {
    //Get userData snapshot,
    return userDataReference.snapshots()
    // then map every ID in the snapshot to a new stream of the corresponding pantry,
        .map((snapshot) => snapshot['subscribed_pantries']
        .map((id) => pantryCollectionReference.doc(id).snapshots())
    // then return the pantry snapshots as list of pantry objects
        .map((pantrySnapshot) => _getPantryFromDocumentSnapshot(pantrySnapshot))
    );
  }

  Future addPantryWithTitle(String title, String uid) async {
    //TODO Move this to add pantry screen
    // final User? user = await authProvider.getCurrentUser();
    // final uid = user?.uid;

    //Add the pantry to the pantries collection
    DocumentReference<Map<String, dynamic>> pantryDocumentReference =
    await pantryCollectionReference.add({
      'title': title,
      'founder': uid,
      'users': [uid],
      'moderators': [uid],

      //TODO Should add with background image
      //TODO Once assistant is created: Add categories and items
    });

    //Add the pantry to the user data in firebase
    userDataReference.update({
      'subscribed_pantries': FieldValue.arrayUnion([pantryDocumentReference.id])
    });

    //TODO Probably move this to add button
    //appStateProvider.switchActiveScreen(1);
  }

}