import 'package:eco/models/brew.dart';
import 'package:eco/models/transpo.dart';
import 'package:eco/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  // final CollectionReference brewCollection = Firestore.instance.collection('brews');
  final CollectionReference transpoCollection = Firestore.instance.collection('transpo');

  Future<void> updateUserData(String name, String cartype, int miles, int mpg) async {
    return await transpoCollection.document(uid).setData({
      'name' : name,
      'cartype': cartype,
      'miles': miles,
      'mpg': mpg,
    });
  }

  // brew list from snapshot
  List<Transpo> _transpoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return Transpo(
          cartype: doc.data['cartype'] ?? '',
          miles: doc.data['miles'] ?? 0,
          mpg: doc.data['mpg'] ?? 0,
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
        mpg: snapshot.data['mpg']
    );
  }

  // get brews stream
  Stream<List<Transpo>> get transpos {
    return transpoCollection.snapshots()
        .map(_transpoListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return transpoCollection.document(uid).snapshots()
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