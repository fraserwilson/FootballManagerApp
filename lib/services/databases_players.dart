import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:screens_ui/models/players.dart';
import 'package:screens_ui/models/user.dart';

class DatabaseService {
  //collection reference for managers
  final String uid;
  final String playeruid;
  DatabaseService({this.uid, this.playeruid});

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
    return await playerCollection
        .doc(uid)
        .collection('Players')
        .doc(playeruid)
        .set({
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

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      playeruid: playeruid,
      name: snapshot.data()['name'],
      postion: snapshot.data()['postion'],
      attack: snapshot.data()['attack'],
      midfield: snapshot.data()['midfield'],
      defense: snapshot.data()['defense'],
      goalkeeping: snapshot.data()['goalkeeping'],
    );
  }

  //get players stream
  Stream<List<Player>> get players {
    return playerCollection.snapshots().map(_playerListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return playerCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
