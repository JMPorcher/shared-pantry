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
    if (pantryIds.isNotEmpty) {
      for (String id in pantryIds) {
            pantryStreams.add(_streamSinglePantry(id));
          }
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
    print('new title to be added: $newTitle');
    pantryCollectionReference.doc(pantryId).update({'title': newTitle});
  }

  Future removePantryFromDatabase(String? pantryId, String? userId) {
    userDataReference.doc(userId).update({
      'subscribed_pantries': FieldValue.arrayRemove([pantryId])
    });
    return pantryCollectionReference.doc(pantryId).delete();
  }

  List<String> filterPantryForUnavailableItems(String? uid) {
    return <String>[]; //TODO Add filter function
  }

  //Category functions, move to db
  void addCategory(String pantryId, String title) {
    pantryCollectionReference
        .doc(pantryId)
        .collection('categories')
        .add({'title' : title});
  }

  void renameCategory(String pantryId, String categoryTitle, String newTitle) {
    pantryCollectionReference
        .doc(pantryId)
        .collection('categories')
        .where('category', isEqualTo: categoryTitle)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.update({'category' : newTitle});
      }
    });
  }

  void deleteCategory(String pantryId, String categoryId) {
    pantryCollectionReference
        .doc(pantryId)
        .collection('categories')
        .doc(categoryId)
        .delete();
  }

  //Item functions
  void addItem(String pantryId, String categoryTitle, String itemTitle) {
    pantryCollectionReference
        .doc(pantryId)
        .collection('categories')
        .where('category', isEqualTo: categoryTitle)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        var itemsRef = doc.reference.collection('items');
        itemsRef.add({itemTitle : false});
      }
    });
  }

  void switchItemAvailability(String pantryId, String categoryTitle, String itemTitle) {
    pantryCollectionReference
        .doc(pantryId)
        .collection('categories')
        .where('category', isEqualTo: categoryTitle)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        Map<String, dynamic> items = doc['items'];
        final bool currentItemAvailability = items[itemTitle];
        final DocumentReference itemRef = doc.reference.collection('items').doc(itemTitle);
        final newAvailability = !currentItemAvailability;
        itemRef.update({itemTitle : newAvailability});
      }
    });
  }

  void deleteItem(String pantryId, String categoryId, String itemId) {
    pantryCollectionReference
        .doc(pantryId).collection('categories')
        .doc(categoryId)
        .collection('items')
        .doc(itemId)
        .delete();
  }
}
