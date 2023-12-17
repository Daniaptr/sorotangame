import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:sorotangame/server/dbservice.dart';

CollectionReference tbDataGame = FirebaseFirestore.instance.collection("game");
CollectionReference tbUser = FirebaseFirestore.instance.collection("users");

class Database {
  //  ---------- METHOD TAMPIL SEMUA DATA ----------  //
  static Stream<QuerySnapshot> getData() {
    return tbDataGame.orderBy('id').snapshots();
  }

  //  ---------- METHOD SEARCH DATAGAME ----------  //
  static Stream<QuerySnapshot> searchDataGame(String keyword) {
    if (keyword.isEmpty) {
      return tbDataGame.snapshots();
    } else {
      return tbDataGame
          .where('name', isGreaterThanOrEqualTo: keyword)
          .where('name', isLessThanOrEqualTo: keyword + '\uf8ff')
          .snapshots();
    }
  }

  static Future<String> uploadImage(File imageFile) async {
    String fileName = basename(imageFile.path);
    Reference ref = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
    if (snapshot.state == TaskState.success) {
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } else {
      throw ('File upload failed, status: ${snapshot.state}');
    }
  }
}
