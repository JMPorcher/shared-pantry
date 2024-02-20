import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/pantry.dart';

class DatabaseService {
  DatabaseService({required this.uid}) {
    userDataReference = FirebaseFirestore.instance.collection('users').doc(uid);
  }

  final String uid;
  late final DocumentReference userDataReference;


  List<String> getPantryIdsFromSnapshot(DocumentSnapshot snapshot) {
     return snapshot['subscribed_pantries'];
  }

  Stream<List<Pantry>> get pantryData {
    //How to build a stream depending on another stream?
    //Get userData snapshot and map subscribed_pantries IDs to a stream with the same pantry id
    List<String> pantryIds = getPantryIdsFromSnapshot(userDataReference.snapshots());
    userDataReference.snapshots()
        .map(
      //Method to convert firestore data into pantries
    )
  }

}