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

  Future<void> updateUserData({String name, String cartype, int miles, int mpg, List energy, double water,
      List food}) async {
    int footprint = 0;  // CALCULATE HERE /////////////////////////////////////////
    return await fpCollection.document(uid).setData({
      'name' : name,
      'cartype': cartype,
      'miles': miles,
      'mpg': mpg,
      'energy': energy,
      'water': water,
      'food': food,
      'footprint': footprint,
    });
  }

  // brew list from snapshot
  List<Footprint> _fpListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return Footprint(
          cartype: doc.data['cartype'] ?? '',
          miles: doc.data['miles'] ?? 0,
          mpg: doc.data['mpg'] ?? 0,
          energy: doc.data['energy'] ?? [0,0,0],
          water: doc.data['water'] ?? 0.0,
          food: doc.data['food'] ?? [0.0,0.0,0.0,0.0,0.0],
          footprint: doc.data['footprint'] ?? 0,
      );
    }).toList();
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        cartype: snapshot.data['cartype'],
        miles: snapshot.data['miles'],
        mpg: snapshot.data['mpg'],
        energy: snapshot.data['energy'],
        water: snapshot.data['water'],
        food: snapshot.data['food'],
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