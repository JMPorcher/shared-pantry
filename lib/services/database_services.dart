import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/pantry.dart';

class DatabaseService {
  DatabaseService() {
    userDataReference = FirebaseFirestore.instance.collection('users');
    pantryCollectionReference =
        FirebaseFirestore.instance.collection('pantries');
  }

  late final CollectionReference userDataReference;
  late final CollectionReference<Map<String, dynamic>>
      pantryCollectionReference;

  Stream<List<String>> streamPantrySubscriptionIds(String? userId) {
    Stream<List<String>> pantryIds =
        userDataReference.doc(userId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        final subscribedPantries =
            snapshot['subscribed_pantries'] as List<dynamic>;
        return subscribedPantries.map((item) => item.toString()).toList();
      } else {
        return [];
      }
    });
    return pantryIds;
  }

  List<Stream<Pantry>> streamPantryList(List<String> pantryIds) {
    List<Stream<Pantry>> pantryStreams = [];
    for (String id in pantryIds) {
      pantryStreams.add(_streamSinglePantry(id));
    }
    return pantryStreams;
  }

  Stream<Pantry> _streamSinglePantry(String id) {
    return pantryCollectionReference
        .doc(id)
        .snapshots()
        .map((snapshot) => _getPantryFromDocumentSnapshot(snapshot));
  }

  Pantry _getPantryFromDocumentSnapshot(DocumentSnapshot doc) {
    return Pantry(
        id: doc.id,
        title: doc['title'],
        moderatorIds: doc['moderators'],
        founderID: doc['founder']);
  }

  Future<DocumentReference> addPantryWithTitle(
      String title, String? userid) async {
    DocumentReference<Map<String, dynamic>> pantryDocumentReference =
        await pantryCollectionReference.add({
      'title': title,
      'founder': userid,
      'users': [userid],
      'moderators': [userid],
      //TODO Should add with background image
      //TODO Once assistant is created: Add categories and items
    });

    userDataReference.doc(userid).update({
      'subscribed_pantries': FieldValue.arrayUnion([pantryDocumentReference.id])
    });
    return pantryDocumentReference;
  }

  Future editPantryTitle(String? pantryId, String newTitle) async {
    pantryCollectionReference.doc(pantryId).update({'title': newTitle});
  }

  Future removePantryFromDatabase(String? uid) {
    return pantryCollectionReference.doc(uid).delete();
  }

  List<String> filterPantryForUnavailableItems(String? uid) {
    return <String>[]; //TODO Add filter function
  }
}
