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
  final List<String> carTypes = ['Gasoline', 'Diesel', 'Electric', 'Public', 'Air'];
  final List<String> energyTypes = ['Electricity', 'Natural Gas', 'Heating Oil & Additional Fuels'];

  // transportation form values
  String _currentName;
  String _currentCarType;
  int _currentMiles;
  int _currentMPG;
  // energy form values
  int _currentElectricity;
  int _currentNaturalGas;
  int _currentHeatingOil;
  int _currentWater;
  // food form values
  double _currentMeatFishEggs;
  double _currentGrains;
  double _currentDairy;
  double _currentFruitsVegetables;
  double _currentSnacksDrinks;


  Column transportation(user, userData, snapshot) { // transportation
    return Column(
      children: <Widget>[
        SizedBox(height: 5.0),

        DropdownButtonFormField(
          value: _currentCarType ?? userData.carType,
          decoration: textInputDecoration,
          items: carTypes.map((carType) {
            return DropdownMenuItem(
              value: carType,
              child: Text('$carType-type transportation'),
            );
          }).toList(),
          onChanged: (val) => setState(() => _currentCarType = val ),
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
                    name: _currentName ?? snapshot.data.name,
                    carType: _currentCarType ?? snapshot.data.carType,
                    miles: _currentMiles ?? snapshot.data.miles,
                    mpg: _currentMPG ?? snapshot.data.mpg,
                    electricity: _currentElectricity ?? snapshot.data.electricity,
                    naturalGas: _currentNaturalGas ?? snapshot.data.naturalGas,
                    heatingOil: _currentHeatingOil ?? snapshot.data.heatingOil,
                    water: _currentWater ?? snapshot.data.water,
                    meatFishEggs: _currentMeatFishEggs ?? snapshot.data.meatFishEggs,
                    grains: _currentGrains ?? snapshot.data.grains,
                    dairy: _currentDairy ?? snapshot.data.dairy,
                    fruitsVegetables: _currentFruitsVegetables ?? snapshot.data.fruitsVegetables,
                    snacksDrinks: _currentSnacksDrinks ?? snapshot.data.snacksDrinks,
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

  Column energy(user, userData, snapshot) { // energy
    return Column(
      children: <Widget>[
        SizedBox(height: 5.0),

        TextFormField(
          initialValue: userData.electricity.toString(),
          decoration: textInputDecoration,
          validator: (val) => val.isEmpty ? 'Please enter electricity cost per year' : null,
          onChanged: (val) => setState(() => _currentElectricity = int.parse(val)),
        ),

        SizedBox(height: 10.0),

        TextFormField(
          initialValue: userData.naturalGas.toString(),
          decoration: textInputDecoration,
          validator: (val) => val.isEmpty ? 'Please enter natural gas cost per year' : null,
          onChanged: (val) => setState(() => _currentNaturalGas = int.parse(val)),
        ),

        SizedBox(height: 10.0),

        TextFormField(
          initialValue: userData.heatingOil.toString(),
          decoration: textInputDecoration,
          validator: (val) => val.isEmpty ? 'Please enter heating oil and additional fuels cost per year' : null,
          onChanged: (val) => setState(() => _currentHeatingOil = int.parse(val)),
        ),

        SizedBox(height: 10.0),

        Slider(
          value: (_currentWater ?? userData.water).toDouble(),
          min: 0.0,
          max: 3.0,
          divisions: 60,
          onChanged: (val) => setState(() => _currentWater = val.round()), // need to make the slider work with doubles, FIX EVENTUALLY
        ),

        // could use a slider for how much % of electricity was from clean energy (solar) and deduct from electricity if we want
        /*Slider(
          value: (_currentMPG ?? userData.mpg).toDouble(),
          // activeColor: Colors.brown[_currentStrength ?? userData.strength],
          // inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
          min: 10,
          max: 120,
          divisions: 13,
          onChanged: (val) => setState(() => _currentMPG = val.round()),
        ),*/

        RaisedButton(
            color: Colors.pink[400],
            child: Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              if(_formKey.currentState.validate()){
                await DatabaseService(uid: user.uid).updateUserData(
                  name: _currentName ?? snapshot.data.name,
                  carType: _currentCarType ?? snapshot.data.carType,
                  miles: _currentMiles ?? snapshot.data.miles,
                  mpg: _currentMPG ?? snapshot.data.mpg,
                  electricity: _currentElectricity ?? snapshot.data.electricity,
                  naturalGas: _currentNaturalGas ?? snapshot.data.naturalGas,
                  heatingOil: _currentHeatingOil ?? snapshot.data.heatingOil,
                  water: _currentWater ?? snapshot.data.water,
                  meatFishEggs: _currentMeatFishEggs ?? snapshot.data.meatFishEggs,
                  grains: _currentGrains ?? snapshot.data.grains,
                  dairy: _currentDairy ?? snapshot.data.dairy,
                  fruitsVegetables: _currentFruitsVegetables ?? snapshot.data.fruitsVegetables,
                  snacksDrinks: _currentSnacksDrinks ?? snapshot.data.snacksDrinks,
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
        return transportation(user, userData, snapshot);
      case 1:
        print("next page");
        return energy(user, userData, snapshot);
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