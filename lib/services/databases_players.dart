import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:screens_ui/models/players.dart';

class DatabaseService {
  //collection reference for managers
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference playerCollection =
      FirebaseFirestore.instance.collection('Managers');

  final CollectionReference managerCollection =
      FirebaseFirestore.instance.collection('Managers');

  Future updateManager(String email, String password) async {
    return await managerCollection
        .doc(uid)
        .set({'email': email, 'password': password});
  }

  Future updatePlayer(String name, String postion, int attack, int midfield,
      int defense, int goalkeeping) async {
    return await playerCollection.doc(uid).collection('Players').doc(uid).set({
      'name': name,
      'postion': postion,
      'attack': attack,
      'midfield': midfield,
      'defense': defense,
      'goalkeeping': goalkeeping,
    });
  }

  //player list from snapshot
  List<Player> _playerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Player(
        name: doc.data()['name'] ?? '',
        postion: doc.data()['postion'] ?? '',
        attack: doc.data()['attack'] ?? '',
        midfield: doc.data()['midfield'] ?? '',
        defense: doc.data()['defense'] ?? '',
        goalkeeping: doc.data()['goalkeeping'] ?? '',
      );
    }).toList();
  }

  //get players stream
  Stream<List<Player>> get players {
    return playerCollection.snapshots().map(_playerListFromSnapshot);
  }
}
