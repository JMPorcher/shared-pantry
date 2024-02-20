import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/pantry.dart';

class DatabaseService {
  DatabaseService({required this.uid}) {
    userDataReference = FirebaseFirestore.instance.collection('users').doc(uid);
    pantryDataReference = FirebaseFirestore.instance.collection('pantries');
  }

  final String uid;
  late final DocumentReference userDataReference;
  late final CollectionReference<Map<String, dynamic>>  pantryDataReference;


  List<Pantry> _getPantryListFromDocumentSnapshot(QuerySnapshot snapshot) {
     return snapshot.docs.map((doc) {
         return
           Pantry(
             pantryID: doc.id,
             title: doc['title'],
             moderatorIds: doc['moderators'],
             founderID: doc['founder']
           );
        }
     ).toList();
  }

  Stream<List<Pantry>> get pantryData {
    //Get userData snapshot,
    return userDataReference.snapshots()
    // then map every ID in the snapshot to a new stream of the corresponding pantry,
        .map((snapshot) => snapshot['subscribed_pantries']
        .map((id) => pantryDataReference.doc(id).snapshots())
    // then return the pantry snapshots as list of pantry objects
        .map((pantrySnapshot) => _getPantryListFromDocumentSnapshot(pantrySnapshot))
    );
  }

}