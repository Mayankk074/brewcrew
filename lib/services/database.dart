import 'package:brewcrew/models/userUid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/brews.dart';

class DatabaseService{

  final String? uid;

  DatabaseService({this.uid});

   // collection Reference
  final CollectionReference brewCollection= FirebaseFirestore.instance
      .collection("brews");

  Future updateUserData(String sugars, String name, int strength) async {

    return await brewCollection.doc(uid).set({
      'sugar': sugars,
      'name': name,
      'strength': strength
    });
  }

  //Brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      final data=doc.data() as Map<String, dynamic>;
      return Brew(
        name: data['name'] ?? '',
        sugars: data['sugar'] ?? '',
        strength: data['strength'] ?? 0,
      );
    }).toList();
  }

  //UserData from snapshot
  UserData _userDatafromSnapshot(DocumentSnapshot snapshot){
    final data=snapshot.data() as Map<String, dynamic>;
    return UserData(
      uid: uid,
      name: data['name'],
      strength: data['strength'],
      sugars: data['sugar'],
    );
  }

  //get brews Stream
  Stream<List<Brew>> get brews{
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData{
    return brewCollection.doc(uid).snapshots()
    .map(_userDatafromSnapshot);
  }
}