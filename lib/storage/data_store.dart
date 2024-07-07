import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage storage = FirebaseStorage.instance;
final FirebaseFirestore fireStore = FirebaseFirestore.instance;
User? firebaseUser = FirebaseAuth.instance.currentUser;

class StoreData {
  // Future<TaskSnapshot> uploadImToSt(Uint8List file) async {
  //   Reference ref = storage.ref().child('profilePicture');
  //   UploadTask uploadTask = ref.putData(file);
  //   TaskSnapshot snapshot = await uploadTask;
  //   String downUrl = await snapshot.ref.getDownloadURL();
  //   return snapshot;
  // }

  Future<String> save({
    required String name,
    required String mobile,
  }) async {
    String res = "Error Occurred";
    try {
      await fireStore
          .collection('userProfile')
          .doc(firebaseUser!.displayName)
          .collection('userInfo')
          .doc(firebaseUser!.email)
          .set({'name': name, 'mobile': mobile});
      res = 'Success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> update({
    required String name,
    required String mobile,
  }) async {
    String res = "Error Occurred";
    try {
      await fireStore
          .collection('userProfile')
          .doc(firebaseUser!.displayName)
          .collection('userInfo')
          .doc(firebaseUser!.email)
          .update({'name': name, 'mobile': mobile});
      res = 'Success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

}
