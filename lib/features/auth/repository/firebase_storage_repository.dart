import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseStorageRepositoryProvider =
    Provider((ref) => FirebaseStorageRepository(FirebaseStorage.instance));

class FirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;

  FirebaseStorageRepository(this.firebaseStorage);

  Future<String> storeFileToDatabase(String ref, File file) async {
    final uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    var taskSnapshot = await uploadTask;
    final downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
