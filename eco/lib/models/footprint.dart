class Footprint {

  final String cartype; // electric, gas, diesel, public, air
  final int miles;
  final int mpg;

  final List energy; // cost per year of electricity, nat gas, and heating oil

  final double water;

  final List food; // meat/eggs, grains, dairy, fruits/veggies, snacks

  final int footprint; // total footprint

  Footprint({ this.cartype, this.miles, this.mpg,
    this.energy, this.water,
    this.food,
    this.footprint,
  });

}