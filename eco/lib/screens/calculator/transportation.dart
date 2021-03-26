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
  double _currentWater;
  // food form values
  double _currentMeatFishEggs;
  double _currentGrains;
  double _currentDairy;
  double _currentFruitsVegetables;
  double _currentSnacksDrinks;

  // transportation controllers
  TextEditingController nameController = new TextEditingController();
  //TextEditingController carTypeController = new TextEditingController();
  TextEditingController milesController = new TextEditingController();
  //TextEditingController mpgController = new TextEditingController();
  // energy controllers
  TextEditingController electricityController = new TextEditingController();
  TextEditingController naturalGasController = new TextEditingController();
  TextEditingController heatingOilController = new TextEditingController();
  TextEditingController waterController = new TextEditingController();
  // food controllers
  /*TextEditingController meatFishEggsController = new TextEditingController();
  TextEditingController grainsController = new TextEditingController();
  TextEditingController dairyController = new TextEditingController();
  TextEditingController fruitsVegetablesController = new TextEditingController();
  TextEditingController snacksDrinksController = new TextEditingController();*/

  @override
  void initState() {
    super.initState();
    nameController.addListener(() => _currentName = nameController.text);
    milesController.addListener(() => _currentMiles = int.parse(milesController.text));
    //mpgController.addListener(() => _currentNaturalGas = int.parse(mpgController.text));

    electricityController.addListener(() => _currentElectricity = int.parse(electricityController.text));
    naturalGasController.addListener(() => _currentNaturalGas = int.parse(naturalGasController.text));
    heatingOilController.addListener(() => _currentHeatingOil = int.parse(heatingOilController.text));
    //waterController.addListener(() => _currentWater = double.parse(waterController.text));

    /*meatFishEggsController.addListener(() => _currentMeatFishEggs = double.parse(meatFishEggsController.text));
    grainsController.addListener(() => _currentGrains = double.parse(grainsController.text));
    dairyController.addListener(() => _currentDairy = double.parse(dairyController.text));
    fruitsVegetablesController.addListener(() => _currentFruitsVegetables = double.parse(fruitsVegetablesController.text));
    snacksDrinksController.addListener(() => _currentSnacksDrinks = double.parse(snacksDrinksController.text));*/
  }

  @override
  void dispose() {
    nameController.dispose();
    milesController.dispose();
    //mpgController.dispose();

    electricityController.dispose();
    naturalGasController.dispose();
    heatingOilController.dispose();
    //waterController.dispose();

    /*meatFishEggsController.dispose();
    grainsController.dispose();
    dairyController.dispose();
    fruitsVegetablesController.dispose();
    snacksDrinksController.dispose();*/
    super.dispose();
  }

  // TODO: labels for sliders and textformfields
  // TODO: have columns move up so keyboard doesn't block them out entirely??
  // TODO: have data be updated when clicking next button as well as update button

  Column transportation(user, userData) { // transportation
    nameController.text = _currentName != null ? _currentName : userData.name;
    milesController.text = _currentMiles != null ? _currentMiles.toString() : userData.miles.toString();
    //mpgController.text = _currentMPG ?? userData.mpg;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,//MainAxisAlignment.end,
      children: <Widget>[
        //SizedBox(height: 5.0),

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

        //SizedBox(height: 10.0),

        TextFormField(
          controller: nameController,
          decoration: textInputDecoration,
          validator: (val) => val.isEmpty ? 'Please enter a name' : null,
        ),

        //SizedBox(height: 10.0),

        TextFormField(
          controller: milesController,
          decoration: textInputDecoration,
          validator: (val) => val.isEmpty ? 'Please enter miles' : null,
        ),

        //SizedBox(height: 10.0),

        Slider(
          value: (_currentMPG ?? userData.mpg).toDouble(),
          min: 10,
          max: 120,
          divisions: 10,
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
                  name: _currentName ?? userData.name,
                  carType: _currentCarType ?? userData.carType,
                  miles: _currentMiles ?? userData.miles,
                  mpg: _currentMPG ?? userData.mpg,
                  electricity: _currentElectricity ?? userData.electricity,
                  naturalGas: _currentNaturalGas ?? userData.naturalGas,
                  heatingOil: _currentHeatingOil ?? userData.heatingOil,
                  water: _currentWater ?? userData.water,
                  meatFishEggs: _currentMeatFishEggs ?? userData.meatFishEggs,
                  grains: _currentGrains ?? userData.grains,
                  dairy: _currentDairy ?? userData.dairy,
                  fruitsVegetables: _currentFruitsVegetables ?? userData.fruitsVegetables,
                  snacksDrinks: _currentSnacksDrinks ?? userData.snacksDrinks,
                );
                Navigator.pop(context);
              }
            }
        ),

        Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              child: Icon(Icons.arrow_forward_rounded),
              onPressed: () {
                pageNum++;
                setState(() => chooseCol(user, userData));
              },
            )
        ),
      ],
    );
  }

  Column energy(user, userData) { // energy
    electricityController.text = _currentElectricity != null ? _currentElectricity.toString() : userData.electricity.toString();
    naturalGasController.text = _currentNaturalGas != null ? _currentNaturalGas.toString() : userData.naturalGas.toString();
    heatingOilController.text = _currentHeatingOil != null ? _currentHeatingOil.toString() : userData.heatingOil.toString();
    //waterController.text = _currentWater != null ? _currentWater.toString() : userData.water.toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,//MainAxisAlignment.end,
      children: <Widget>[
        //SizedBox(height: 5.0),

        TextFormField(
          controller: electricityController,
          decoration: textInputDecoration,
          validator: (val) => val.isEmpty ? 'Please enter electricity cost per year' : null,
        ),

        //SizedBox(height: 10.0),

        TextFormField(
          controller: naturalGasController,
          decoration: textInputDecoration,
          validator: (val) => val.isEmpty ? 'Please enter natural gas cost per year' : null,
        ),

        //SizedBox(height: 10.0),

        TextFormField(
          controller: heatingOilController,
          decoration: textInputDecoration,
          validator: (val) => val.isEmpty ? 'Please enter heating oil and additional fuels cost per year' : null,
        ),

        //SizedBox(height: 10.0),

        Slider(
          value: (_currentWater ?? userData.water).toDouble(),
          min: 0.0,
          max: 3.0,
          divisions: 12,
          onChanged: (val) => setState(() => _currentWater = val),
        ),

        RaisedButton(
            color: Colors.pink[400],
            child: Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              print("current natural gas: " + _currentNaturalGas.toString());
              if(_formKey.currentState.validate()){
                await DatabaseService(uid: user.uid).updateUserData(
                  name: _currentName ?? userData.name,
                  carType: _currentCarType ?? userData.carType,
                  miles: _currentMiles ?? userData.miles,
                  mpg: _currentMPG ?? userData.mpg,
                  electricity: _currentElectricity ?? userData.electricity,
                  naturalGas: _currentNaturalGas ?? userData.naturalGas,
                  heatingOil: _currentHeatingOil ?? userData.heatingOil,
                  water: _currentWater ?? userData.water,
                  meatFishEggs: _currentMeatFishEggs ?? userData.meatFishEggs,
                  grains: _currentGrains ?? userData.grains,
                  dairy: _currentDairy ?? userData.dairy,
                  fruitsVegetables: _currentFruitsVegetables ?? userData.fruitsVegetables,
                  snacksDrinks: _currentSnacksDrinks ?? userData.snacksDrinks,
                );
                Navigator.pop(context);
              }
            }
        ),

        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton(
              child: Icon(Icons.arrow_back_rounded),
              onPressed: () {
                pageNum--;
                setState(() => chooseCol(user, userData));
              },
            ),
            TextButton(
              child: Icon(Icons.arrow_forward_rounded),
              onPressed: () {
                pageNum++;
                setState(() => chooseCol(user, userData));
              },
            )
          ]
        )
      ],
    );
  }

  Column food(user, userData) { // food
    /*meatFishEggsController.text = _currentMeatFishEggs != null ? _currentMeatFishEggs.toString() : userData.meatFishEggs.toString();
    grainsController.text = _currentGrains != null ? _currentGrains.toString() : userData.grains.toString();
    dairyController.text = _currentDairy != null ? _currentDairy.toString() : userData.dairy.toString();
    fruitsVegetablesController.text = _currentFruitsVegetables != null ? _currentFruitsVegetables.toString() : userData.fruitsVegetables.toString();
    snacksDrinksController.text = _currentSnacksDrinks != null ? _currentSnacksDrinks.toString() : userData.snacksDrinks.toString();*/
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,//MainAxisAlignment.end,
      children: <Widget>[
        //SizedBox(height: 5.0),

        Slider(
          value: (_currentMeatFishEggs ?? userData.meatFishEggs).toDouble(),
          min: 0.0,
          max: 3.0,
          divisions: 12,
          onChanged: (val) => setState(() => _currentMeatFishEggs = val),
        ),

        //SizedBox(height: 10.0),

        Slider(
          value: (_currentGrains ?? userData.grains).toDouble(),
          min: 0.0,
          max: 3.0,
          divisions: 12,
          onChanged: (val) => setState(() => _currentGrains = val),
        ),

        //SizedBox(height: 10.0),

        Slider(
          value: (_currentDairy ?? userData.dairy).toDouble(),
          min: 0.0,
          max: 3.0,
          divisions: 12,
          onChanged: (val) => setState(() => _currentDairy = val),
        ),

        //SizedBox(height: 10.0),

        Slider(
          value: (_currentFruitsVegetables ?? userData.fruitsVegetables).toDouble(),
          min: 0.0,
          max: 3.0,
          divisions: 12,
          onChanged: (val) => setState(() => _currentFruitsVegetables = val),
        ),

        //SizedBox(height: 10.0),

        Slider(
          value: (_currentSnacksDrinks ?? userData.snacksDrinks).toDouble(),
          min: 0.0,
          max: 3.0,
          divisions: 12,
          onChanged: (val) => setState(() => _currentSnacksDrinks = val),
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
                  name: _currentName ?? userData.name,
                  carType: _currentCarType ?? userData.carType,
                  miles: _currentMiles ?? userData.miles,
                  mpg: _currentMPG ?? userData.mpg,
                  electricity: _currentElectricity ?? userData.electricity,
                  naturalGas: _currentNaturalGas ?? userData.naturalGas,
                  heatingOil: _currentHeatingOil ?? userData.heatingOil,
                  water: _currentWater ?? userData.water,
                  meatFishEggs: _currentMeatFishEggs ?? userData.meatFishEggs,
                  grains: _currentGrains ?? userData.grains,
                  dairy: _currentDairy ?? userData.dairy,
                  fruitsVegetables: _currentFruitsVegetables ?? userData.fruitsVegetables,
                  snacksDrinks: _currentSnacksDrinks ?? userData.snacksDrinks,
                );
                Navigator.pop(context);
              }
            }
        ),

        Align(
            alignment: Alignment.bottomLeft,
            child: TextButton(
              child: Icon(Icons.arrow_back_rounded),
              onPressed: () {
                pageNum--;
                setState(() => chooseCol(user, userData));
              },
            )
        ),
      ],
    );
  }

  int pageNum = 0;
  //int colNum = 3;

  Column chooseCol(user, userData) {
    switch(pageNum) {
      case 0:
        return transportation(user, userData);
      case 1:
        return energy(user, userData);
      case 2:
        return food(user, userData);
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
              child: chooseCol(user, userData)/*Column(
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
  }
}

// old code

/*Align(
  alignment: Alignment.bottomLeft,
  child: TextButton(
    child: Icon(Icons.arrow_back_rounded),
    onPressed: () {
      pageNum--;
      setState(() => chooseCol(user, userData));
    },
  )
),*/

/*Align(
  alignment: Alignment.bottomRight,
  child: TextButton(
    child: Icon(Icons.arrow_forward_rounded),
    onPressed: () {
      pageNum++;
      setState(() => chooseCol(user, userData));
    },
  )
),*/

/*Row(
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
            setState(() => chooseCol(user, userData));
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
            } else {
              setState(() => chooseCol(user, userData));
            }
          },
          child: Text('Next Page')
      ),
    )
  ]
),*/

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

//pageButtons(pageNum, user, userData, snapshot),
/*Row(
  //mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    /*new Container(
      //padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(right: 70.0, top: 10.0),
      //height: 100.0,
      //width: 100.0,
      child: TextButton(
        child: Icon(Icons.arrow_back_rounded),
        onPressed: () {
          pageNum--;
          if (pageNum < 0) {
            pageNum = 0;
          } else {
            setState(() => chooseCol(user, userData));
          }
        },
      )
    ),*/
    /*new Container(
      //padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 70.0, top: 10.0),
      //height: 100.0,
      //width: 100.0,
      child: TextButton(
        child: Icon(Icons.arrow_forward_rounded),
        onPressed: () {
          pageNum++;
          if (pageNum >= colNum) {
            pageNum = colNum - 1;
          } else {
            setState(() => chooseCol(user, userData));
          }
        },
      ),
    ),*/
    /*Align(
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: Icon(Icons.arrow_forward_rounded)
      )
    )*/

  ]
),*/

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

/*Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    new Container(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
          onPressed: () {
            pageNum--;
            if (pageNum < 0) {
              pageNum = 0;
            } else {
              setState(() => chooseCol(user, userData));
            }
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
            } else {
              setState(() => chooseCol(user, userData));
            }
          },
          child: Text('Next Page')
      ),
    )
  ]
),*/