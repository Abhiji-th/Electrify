import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;

  DatabaseService({ required this.uid });

  final CollectionReference usercollection = FirebaseFirestore.instance.collection('userdetails');

  Future updateUserData(String name, String id, String pnum) async {
      return await usercollection.doc(uid).set({
        'name': name,
        'id': id,
        'pnum': pnum,
      });
    }
  Stream<QuerySnapshot> get users{
    return usercollection.snapshots();
  }

  Future getCurrentUserData() async{
    try {
      DocumentSnapshot ds = await usercollection.doc(uid).get();
      String name = ds.get('name');
      String id = ds.get('id');
      String pnum = ds.get('pnum');
      return [name,id,pnum];
    } on Exception catch (e) {
      return null;
    }
  }

}
