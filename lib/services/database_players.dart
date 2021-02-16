import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:screens_ui/models/players.dart';

class PlayerDatabaseService {
  final String uid;
  PlayerDatabaseService({this.uid});
  //collection reference
  final CollectionReference playerCollection =
      FirebaseFirestore.instance.collection('Players');

  Future updateUserData(String uid, String name, String position, int attack,
      int midifled, int defense, int goalkeeping, bool isAvaliable) async {
    return await playerCollection.doc(uid).set({
      'uid': uid,
      'name': name,
      'position': position,
      'attack': attack,
      'midifled': midifled,
      'defense': defense,
      'goalkeeping': goalkeeping,
      'isAvaliable': isAvaliable,
    });
  }

  //list of players from snapshot
  List<PlayersModel> _playerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PlayersModel(
        uid: doc.data()['uid'] ?? ' ',
        name: doc.data()['name'] ?? ' ',
        position: doc.data()['position'] ?? ' ',
        attack: doc.data()['attack'] ?? 0,
        midfield: doc.data()['midfield'] ?? 0,
        defense: doc.data()['defense'] ?? 0,
        goalkeeping: doc.data()['goalkeeping'] ?? 0,
        isAvaliable: doc.data()['isAvaliable'] ?? true,
      );
    }).toList();
  }

  //stream of players
  Stream<List<PlayersModel>> get players {
    return playerCollection.snapshots().map(_playerListFromSnapshot);
  }
}
