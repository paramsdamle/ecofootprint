import 'package:eco/models/brew.dart';
import 'package:eco/models/footprint.dart';
import 'package:eco/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  // final CollectionReference brewCollection = Firestore.instance.collection('brews');
  final CollectionReference fpCollection = Firestore.instance.collection('footprint');

  //Future<void> updateUserData({String name, String carType, int miles, int mpg, List energy, double water, List food}) async {
  Future<void> updateUserData({String name, String carType, int miles, int mpg,
                               int electricity, int naturalGas, int heatingOil, double water,
                               double meatFishEggs, double grains, double dairy, double fruitsVegetables, double snacksDrinks}) async {
    // users can only have one type of transportation currently? So can't calculate air travel or transit or diesel?
    double gasFootprint = (miles / mpg) * 0.011196916; // co2 per gallon
    double mfgFootprint = (miles / mpg) * 0.0000056;
    double electricityFootprint = electricity * 0.0049595; // co2 per dollar
    double naturalGasFootprint = naturalGas * 0.0049098;
    double heatingOilFootprint = heatingOil * 0.004953;
    // could include living space area which measures for construction
    double waterFootprint = water * 0.87; // co2 per amount used compared to other households
    double meatFishEggsFootprint = meatFishEggs * 1.09;
    double grainsFootprint = grains * 0.35;
    double dairyFootprint = dairy * 0.41;
    double fruitsVegetablesFootprint = fruitsVegetables * 0.33;
    int footprint = (gasFootprint + mfgFootprint + electricityFootprint + naturalGasFootprint + heatingOilFootprint + waterFootprint +
                     meatFishEggsFootprint + grainsFootprint + dairyFootprint + fruitsVegetablesFootprint).round();  // measured in tons of CO2
    print("Footprint: " + footprint.toString());
    return await fpCollection.document(uid).setData({
      'name' : name,
      'carType': carType,
      'miles': miles,
      'mpg': mpg,
      'electricity': electricity,
      'naturalGas': naturalGas,
      'heatingOil': heatingOil,
      'water': water,
      'meatFishEggs': meatFishEggs,
      'grains': grains,
      'dairy': dairy,
      'fruitsVegetables': fruitsVegetables,
      'snacksDrinks': snacksDrinks,
      'footprint': footprint,
    });
  }

  // brew list from snapshot
  List<Footprint> _fpListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Footprint(
          carType: doc.data['carType'] ?? '',
          miles: doc.data['miles'] ?? 0,
          mpg: doc.data['mpg'] ?? 0,
          electricity: doc.data['electricity'] ?? 0,
          naturalGas: doc.data['naturalGas'] ?? 0,
          heatingOil: doc.data['heatingOil'] ?? 0,
          water: doc.data['water'] ?? 0.0,
          meatFishEggs: doc.data['meatFishEggs'] ?? 0.0,
          grains: doc.data['grains'] ?? 0.0,
          dairy: doc.data['dairy'] ?? 0.0,
          fruitsVegetables: doc.data['fruitsVegetables'] ?? 0.0,
          snacksDrinks: doc.data['snacksDrinks'] ?? 0.0,
          footprint: doc.data['footprint'] ?? 0,
      );
    }).toList();
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        carType: snapshot.data['carType'],
        miles: snapshot.data['miles'],
        mpg: snapshot.data['mpg'],
        electricity: snapshot.data['electricity'],
        naturalGas: snapshot.data['naturalGas'],
        heatingOil: snapshot.data['heatingOil'],
        water: snapshot.data['water'],
        meatFishEggs: snapshot.data['meatFishEggs'],
        grains: snapshot.data['grains'],
        dairy: snapshot.data['dairy'],
        fruitsVegetables: snapshot.data['fruitsVegetables'],
        snacksDrinks: snapshot.data['snacksDrinks'],
        footprint: snapshot.data['footprint']
    );
  }

  // get brews stream
  Stream<List<Footprint>> get footprints {
    return fpCollection.snapshots()
        .map(_fpListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return fpCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }
}
  //
  // Future<void> updateUserData2(String sugars, String name, int strength) async {
  //   return await brewCollection.document(uid).setData({
  //     'sugars': sugars,
  //     'name': name,
  //     'strength': strength,
  //   });
  // }
  //
  // // brew list from snapshot
  // List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.documents.map((doc){
  //     //print(doc.data);
  //     return Brew(
  //       name: doc.data['name'] ?? '',
  //       strength: doc.data['strength'] ?? 0,
  //       sugars: doc.data['sugars'] ?? '0'
  //     );
  //   }).toList();
  // }
  //
  // // user data from snapshots
  // UserData _userDataFromSnapshot2(DocumentSnapshot snapshot) {
  //   return UserData(
  //     uid: uid,
  //     name: snapshot.data['name'],
  //     sugars: snapshot.data['sugars'],
  //     strength: snapshot.data['strength']
  //   );
  // }
  //
  // // get brews stream
  // Stream<List<Brew>> get brews2 {
  //   return brewCollection.snapshots()
  //     .map(_brewListFromSnapshot);
  // }
  //
  // // get user doc stream
  // Stream<UserData> get userData2 {
  //   return brewCollection.document(uid).snapshots()
  //     .map(_userDataFromSnapshot);
  // }
// }