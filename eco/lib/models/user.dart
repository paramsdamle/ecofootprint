class User {

  final String uid;
  
  User({ this.uid });

}

class UserData {

  final String uid;
  final String name;
  final String cartype;
  final int miles;
  final int mpg;

  final List energy; // cost per year of electricity, nat gas, and heating oil <Int>

  final double water;

  final List food; // meat/eggs, grains, dairy, fruits/veggies, snacks <Double>

  final int footprint; // total footprint

  UserData({ this.uid, this.name, this.cartype, this.miles, this.mpg, this.energy, this.water,
    this.food,
    this.footprint,
  });

}