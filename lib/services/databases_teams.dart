import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:screens_ui/models/teams.dart';
import 'package:screens_ui/models/user.dart';

class DatabaseService {
  //collection reference for managers
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference teamCollection =
      FirebaseFirestore.instance.collection('Teams');

  Future updateUserData(String teamName, String managerName) async {
    return await teamCollection
        .doc(uid)
        .set({'teamName': teamName, 'managerName': managerName, 'docID': uid});
  }

  //list of Team from a snapshot
  List<Team> _teamListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Team(
          teamName: doc.data()['teamName'] ?? '',
          managerName: doc.data()['managerName'] ?? '',
          docId: doc.data()['docID'] ?? '');
    }).toList();
  }

  //getting a userData object from the snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        teamName: snapshot.data()['teamName'],
        managerName: snapshot.data()['managerName']);
  }

  //get team stream
  Stream<List<Team>> get teams {
    return teamCollection.snapshots().map(_teamListFromSnapshot);
  }

  //getting a users documents stream
  Stream<UserData> get userData {
    return teamCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
