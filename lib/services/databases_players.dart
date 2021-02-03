import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  //collection reference for managers
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference playerCollection =
      FirebaseFirestore.instance.collection('Managers');

  Future updatePlayer(String name, String postion, int attack, int midfield,
      int defense, int goalkeeping) async {
    return await playerCollection
        .doc(uid)
        .collection('Players')
        .doc('Player Details')
        .set({
      'name': name,
      'postion': postion,
      'attack': attack,
      'midfield': midfield,
      'defense': defense,
      'goalkeeping': goalkeeping,
    });
  }

  //get players stream
  Stream<QuerySnapshot> get players {
    return playerCollection.snapshots();
  }
}
