import 'package:flutter/material.dart';
import 'package:screens_ui/home/team_players.dart';
import 'package:screens_ui/models/teams.dart';

class TeamTile extends StatelessWidget {
  final Team team;
  TeamTile({this.team});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundImage: AssetImage('assets/soccerball.jpg'),
          ),
          title: Text(team.teamName),
          subtitle: Text('Manager: ${team.managerName}'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TeamPlayers()));
          },
        ),
      ),
    );
  }
}
