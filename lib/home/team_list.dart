import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screens_ui/home/team_tile.dart';
import 'package:screens_ui/models/teams.dart';

class TeamList extends StatefulWidget {
  @override
  _TeamListState createState() => _TeamListState();
}

class _TeamListState extends State<TeamList> {
  @override
  Widget build(BuildContext context) {
    final teams = Provider.of<List<Team>>(context) ?? [];

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: teams.length,
      itemBuilder: (context, index) {
        return TeamTile(team: teams[index]);
      },
    );
  }
}
