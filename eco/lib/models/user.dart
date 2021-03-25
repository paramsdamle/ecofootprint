class User {

  final String uid;
  
  User({ this.uid });

}

class UserData {

  final String uid;
  final String name;
  final String carType;
  final int miles;
  final int mpg;

  final int electricity; // cost per year of electricity, nat gas, and heating oil
  final int naturalGas;
  final int heatingOil;
  final double water;

  final double meatFishEggs; // amount of usage as a percent compared to normal
  final double grains;
  final double dairy;
  final double fruitsVegetables;
  final double snacksDrinks;

  final int footprint; // total footprint

  UserData({
    this.uid,
    this.name,
    this.carType,
    this.miles,
    this.mpg,
    this.electricity,
    this.naturalGas,
    this.heatingOil,
    this.water,
    this.meatFishEggs,
    this.fruitsVegetables,
    this.snacksDrinks,
    this.dairy,
    this.grains,
    this.footprint,
  });

}