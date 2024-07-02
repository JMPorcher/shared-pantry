import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_pantry/models/item_category.dart';

import '../models/item.dart';
import '../models/pantry.dart';

class DatabaseService {
  DatabaseService() {
    userCollectionReference = FirebaseFirestore.instance.collection('users');
    pantryCollectionReference =
        FirebaseFirestore.instance.collection('pantries');
  }

  late final CollectionReference userCollectionReference;
  late final CollectionReference<Map<String, dynamic>>
      pantryCollectionReference;

  Stream<List<String>> streamPantrySubscriptionIds(String? userId) {
    Stream<List<String>> pantryIds =
        userCollectionReference.doc(userId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        final subscribedPantries =
            snapshot['subscribed_pantries'] as List<dynamic>;
        return subscribedPantries.map((id) => id.toString()).toList();
      } else {
        return [];
      }
    });
    return pantryIds;
  }

  Pantry getPantryFromDocumentSnapshot(DocumentSnapshot doc) {
    List<ItemCategory> categories = [];
    List<dynamic> categoryDocs = doc['categories'] ?? [];

    for (var categoryDoc in categoryDocs) {
      String categoryName = categoryDoc['category'];
      List<Item> items = [];

      for (var itemDoc in categoryDoc['items']) {
        String itemName = itemDoc.keys.first;
        items.add(Item(itemName));
      }

      categories.add(ItemCategory(categoryName, items: items));
    }

    return Pantry(
        id: doc.id,
        title: doc['title'],
        moderatorIds: doc['moderators'],
        founderID: doc['founder'],
        categories: categories
        );

    //TODO Get categories with items
    //TODO Get users
  }

  Future<DocumentReference> addPantry(String title, String? userid) async {
    DocumentReference<Map<String, dynamic>> pantryDocumentReference =
        await pantryCollectionReference.add({
      'title': title,
      'founder': userid,
      'users': [userid],
      'moderators': [userid],
      'categories' : []
      //TODO Should add with background image
      //TODO Once assistant is created: Add categories and items
    });

    userCollectionReference.doc(userid).update({
      'subscribed_pantries': FieldValue.arrayUnion([pantryDocumentReference.id])
    });
    return pantryDocumentReference;
  }

  Future renamePantry(String? pantryId, String newTitle) async {
    pantryCollectionReference.doc(pantryId).update({'title': newTitle});
  }

  Future removePantryFromDatabase(String? pantryId, String? userId) {
    userCollectionReference.doc(userId).update({
      'subscribed_pantries': FieldValue.arrayRemove([pantryId])
    });
    return pantryCollectionReference.doc(pantryId).delete();
  }

  List<String> filterPantryForUnavailableItems(String? uid) {
    return <String>[]; //TODO Add filter function
  }

  //Category functions, move to db
  void addCategory(String? pantryId, String title) {
    pantryCollectionReference
        .doc(pantryId)
        .collection('categories')
        .add({'title' : title, 'items' : []});
  }

  void renameCategory(String? pantryId, String categoryTitle, String newTitle) {
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


  // User Functions
  Future<void> deleteUser(User? user) async {
    final List<dynamic> userPantryIdsDynamic = await userCollectionReference
        .doc(user?.uid)
        .get()
        .then((snapshot) => 
              snapshot.get('subscribed_pantries') as List<dynamic>);
    final List<String> userPantryIds = userPantryIdsDynamic.map((entry) => entry.toString()).toList();

    for (String pantryId in userPantryIds) {
      deleteOrLeavePantry(pantryId, user);
    }

    await userCollectionReference.doc(user?.uid).delete();
  }

  Future<void> deleteOrLeavePantry(String pantryId, User? user) async {
      final DocumentReference pantryReference = pantryCollectionReference
          .doc(pantryId);

      final DocumentSnapshot pantrySnapshot = await pantryReference.get();
      final List<dynamic> users = pantrySnapshot['users'];

      if (users.length == 1) {
        removePantryFromDatabase(pantryId, user?.uid);
      } else {
        await pantryReference.update(
            {'users': FieldValue.arrayRemove([user?.uid])});
      }

      //TODO Give admin rights to everyone in the group when leaving user is the founder
  }
}
