import 'package:firebase_auth/firebase_auth.dart';
import 'package:screens_ui/models/user.dart';
import 'package:screens_ui/services/database_players.dart';
import 'package:screens_ui/services/databases_teams.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create a user object based on a Firebase User

  ConvertedUser _userFromFirebaseUser(User user) {
    return user != null ? ConvertedUser(uid: user.uid) : null;
  }

  //auth changes user streams
  Stream<ConvertedUser> get streamuser {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sign in anonumously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in email
  Future signInWithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register email pasword
  Future registerWithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      //create a new document
      await DatabaseService(uid: user.uid)
          .updateUserData('Retro FC', 'new manager');
      await PlayerDatabaseService(uid: user.uid)
          .updateUserData(user.uid, 'John', 'GK', 1, 1, 1, 1, true);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
