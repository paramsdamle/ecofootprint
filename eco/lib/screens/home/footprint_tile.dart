import 'package:eco/models/footprint.dart';
import 'package:flutter/material.dart';

class FootprintTile extends StatelessWidget {

  final Footprint fp;
  FootprintTile({ this.fp });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.green[100],
            // backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(fp.name),
          subtitle: Text('Has a carbon footprint of ${fp.footprint} tons'),
        ),
      ),
    );
  }
}