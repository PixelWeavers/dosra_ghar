import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> _uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveData({
    required String name,
    required String description,
    required Uint8List file,
  }) async {
    String resp = "Some error occured";
    print("Hiiii");
    try {
      if (name.isNotEmpty || description.isNotEmpty) {
        print("Hiiiiiiii");
        String imageUrl = await _uploadImageToStorage('ProfileImage', file);
        await _firestore.collection("lostItem").add({
          "name": name,
          "description": description,
          'imageLink': imageUrl,
        });
        resp = "Success";
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}
