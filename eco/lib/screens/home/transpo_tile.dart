import 'package:eco/models/transpo.dart';
import 'package:flutter/material.dart';

class TranspoTile extends StatelessWidget {

  final Transpo transpo;
  TranspoTile({ this.transpo });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[100],
            // backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(transpo.cartype),
          subtitle: Text('Has ${transpo.mpg} miles per gallon'),
        ),
      ),
    );
  }
}