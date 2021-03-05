import 'package:eco/models/user.dart';
import 'package:eco/services/database.dart';
import 'package:eco/shared/constants.dart';
import 'package:eco/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String>  cartypes = ['Gasoline', 'Diesel', 'Electric', 'Public', 'Air'];
  // final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900];

  // form values
  String _currentName;
  String _currentCartype;
  int _currentMiles;
  int _currentMPG;

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Add Personal Vehicle.',
                    style: TextStyle(fontSize: 18.0),
                  ),

                  SizedBox(height: 20.0),

                  DropdownButtonFormField(
                    value: _currentCartype ?? userData.cartype,
                    decoration: textInputDecoration,
                    items: cartypes.map((cartype) {
                      return DropdownMenuItem(
                        value: cartype,
                        child: Text('$cartype-type transportation'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentCartype = val ),
                  ),

                  SizedBox(height: 10.0),

                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),

                  SizedBox(height: 10.0),


                  TextFormField(
                    initialValue: userData.miles.toString(),
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty ? 'Please enter miles' : null,
                    onChanged: (val) => setState(() => _currentMiles = int.parse(val)),
                  ),

                  SizedBox(height: 10.0),

                  Slider(
                    value: (_currentMPG ?? userData.mpg).toDouble(),
                    // activeColor: Colors.brown[_currentStrength ?? userData.strength],
                    // inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                    min: 10,
                    max: 120,
                    divisions: 13,
                    onChanged: (val) => setState(() => _currentMPG = val.round()),
                  ),


                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? snapshot.data.name,
                              _currentCartype ?? snapshot.data.cartype,
                              _currentMiles ?? snapshot.data.miles,
                              _currentMPG ?? snapshot.data.mpg
                          );
                          Navigator.pop(context);
                        }
                      }
                  ),



                ],
              ),
            );
          } else {
            return Loading();
          }
        }
    );
  }
}