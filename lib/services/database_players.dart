import 'package:cloud_firestore/cloud_firestore.dart';

class PlayerDatabaseService {
  final String uid;
  PlayerDatabaseService({this.uid});
  //collection reference
  final CollectionReference playerCollection =
      FirebaseFirestore.instance.collection('Players');

  Future updateUserData(String name, String position, int attack, int midifled,
      int defense, int goalkeeping, bool isAvaliable) async {
    return await playerCollection.doc(uid).set({
      'name': name,
      'position': position,
      'attack': attack,
      'midifled': midifled,
      'defense': defense,
      'goalkeeping': goalkeeping,
      'isAvaliable': isAvaliable,
    });
  }
}
