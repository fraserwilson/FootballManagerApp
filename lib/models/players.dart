import 'package:cloud_firestore/cloud_firestore.dart';

class PlayersModel {
  final String name;
  final String position;
  final int attack;
  final int midfield;
  final int defense;
  final int goalkeeping;
  final bool isAvaliable;

  PlayersModel(
      {this.name,
      this.position,
      this.attack,
      this.midfield,
      this.defense,
      this.goalkeeping,
      this.isAvaliable});

  factory PlayersModel.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data();
    return PlayersModel(
        name: data['name'],
        position: data['position'],
        attack: data['attack'],
        midfield: data['midfield'],
        defense: data['defense'],
        goalkeeping: data['goalkeeping'],
        isAvaliable: data['isAvaliable']);
  }
}
