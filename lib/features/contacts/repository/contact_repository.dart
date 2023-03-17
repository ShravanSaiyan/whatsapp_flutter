import 'package:cloud_firestore/cloud_firestore.dart';

class ContactRepository {
  final FirebaseFirestore firestore;

  const ContactRepository({
    required this.firestore,
  });
}
