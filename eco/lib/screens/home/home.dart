import 'package:eco/screens/calculator/transportation.dart'; //SettingsForm
import 'package:eco/services/auth.dart';
import 'package:eco/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eco/models/footprint.dart';
import 'package:eco/screens/home/footprint_list.dart';


class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm()
        );
      });
    }

    return StreamProvider<List<Footprint>>.value(
      value: DatabaseService().footprints,
      child: Scaffold(
        backgroundColor: Colors.green[50],
        appBar: AppBar(
          title: Text('Eco Footprint'),
          backgroundColor: Colors.green[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            // image: DecorationImage(
            //   // image: AssetImage('assets/coffee_bg.png'),
            //   fit: BoxFit.cover,
            // ),
          ),
          child: FootprintList()
        ),
      ),
    );
  }
}