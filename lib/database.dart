import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });

  final CollectionReference detailcollection = FirebaseFirestore.instance.collection('details');

  Future updateUserData(String CId, int pnum) async {
    return await detailcollection.doc(uid).set({
      'CId': CId,
      'pnum': pnum,
    });
  }
}