class ConvertedUser {
  final String uid;
  final String playeruid;
  ConvertedUser({this.uid, this.playeruid});
}

class UserData {
  final String playeruid;
  final String name;
  final String postion;
  final int attack;
  final int midfield;
  final int defense;
  final int goalkeeping;

  UserData(
      {this.playeruid,
      this.name,
      this.postion,
      this.attack,
      this.midfield,
      this.defense,
      this.goalkeeping});
}
