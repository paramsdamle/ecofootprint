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
  final List<String> cartypes = ['Gasoline', 'Diesel', 'Electric', 'Public', 'Air'];

  // form values
  String _currentName;
  String _currentCartype;
  int _currentMiles;
  int _currentMPG;

  /*void _showSettingsPanel2() {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
        child: SettingsForm2(),
      );
    });
  }*/

  Column col0(user, userData, snapshot) {
    return Column(
      children: <Widget>[
        SizedBox(height: 5.0),

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
                    name:_currentName ?? snapshot.data.name,
                    cartype:_currentCartype ?? snapshot.data.cartype,
                    miles:_currentMiles ?? snapshot.data.miles,
                    mpg:_currentMPG ?? snapshot.data.mpg,
                    energy: snapshot.data.energy,

                    ////////////////
                );
                Navigator.pop(context);
              }
            }
        ),

        //pageButtons(pageNum, user, userData, snapshot),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton.icon(
                  onPressed: () {
                    pageNum--;
                    if (pageNum < 0) {
                      pageNum = 0;
                    }
                    setState(() => chooseCol(user, userData, snapshot));
                  },
                  label: Text(''),
                  icon: Icon(Icons.arrow_back_rounded),
                ),
              ),
              new Container(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton.icon(
                    onPressed: () {
                      pageNum++;
                      if (pageNum >= colNum) {
                        pageNum = colNum - 1;
                      }
                      setState(() => chooseCol(user, userData, snapshot));
                    },
                    label: Text(''),
                    icon: Icon(Icons.arrow_forward_rounded)
                ),
              )
            ]
        ),
      ],
    );
  }

  Column col1(user, userData, snapshot) {
    return Column(
      children: <Widget>[
        SizedBox(height: 5.0),

        DropdownButtonFormField(
          value: _currentCartype ?? userData.cartype,
          decoration: textInputDecoration,
          items: cartypes.map((cartype) {
            return DropdownMenuItem(
              value: cartype,
              child: Text('$cartype-type energy'),
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

        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () {
                      pageNum--;
                      if (pageNum < 0) {
                        pageNum = 0;
                      }
                      setState(() => chooseCol(user, userData, snapshot));
                    },
                    child: Text('Previous Page')
                ),
              ),
              new Container(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () {
                      pageNum++;
                      if (pageNum >= colNum) {
                        pageNum = colNum - 1;
                      }
                      setState(() => chooseCol(user, userData, snapshot));
                    },
                    child: Text('Next Page')
                ),
              )
            ]
        ),
      ],
    );
  }

  int pageNum = 0;
  int colNum = 2;

  Column chooseCol(user, userData, snapshot) {
    switch(pageNum) {
      case 0:
        return col0(user, userData, snapshot);
      case 1:
        return col1(user, userData, snapshot);
    }
    return null;
  }

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
              child: chooseCol(user, userData, snapshot)/*Column(
                children: <Widget>[
                  /*ElevatedButton(
                    onPressed: () {
                      pageNum++;
                      print("pageNum: " + pageNum.toString());
                      switch(pageNum) {
                        case 1:
                          return page1;
                      }
                    },
                    child: Text('Next'),
                  ),
                  Text(
                    'Add Personal Vehicle.',
                    style: TextStyle(fontSize: 18.0),
                  ),*/
                  SizedBox(height: 5.0),
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
              )*/,
            );
          } else {
            return Loading();
          }
        }
    );


    /*StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData userData = snapshot.data;
            return Container(
              child: Column (
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      pageNum++;
                      switch(pageNum) {
                        case 0:
                          return page0;
                          break;
                        /*case 1:
                          return _Page1State(user);
                          break;*/
                      }
                    },
                    child: Text('Next')
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Add Personal Vehicle.',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(height: 5.0),//changed this from 20 to 5 to stop getting an overflow warning, may want to look into SingleChildScrollView
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
                        )
                      ],
                    ),
                )
              ]
              ));
          } else {
            return Loading();
          }
        }
    );*/
  }
}