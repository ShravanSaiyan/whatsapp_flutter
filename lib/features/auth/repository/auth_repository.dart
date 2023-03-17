import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_flutter/contacts_info.dart';
import 'package:whatsapp_flutter/features/auth/repository/firebase_storage_repository.dart';
import 'package:whatsapp_flutter/features/screens/otp_screen.dart';
import 'package:whatsapp_flutter/features/screens/user_information_screen.dart';
import 'package:whatsapp_flutter/models/user.dart';
import 'package:whatsapp_flutter/screens/mobile_screen_layout.dart';
import 'package:whatsapp_flutter/utils/common_utils.dart';
import 'package:whatsapp_flutter/utils/custom_alert_dialog.dart';

final authRepositoryProvider = Provider((reference) =>
    AuthRepository(FirebaseAuth.instance, FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository(this.auth, this.firestore);

  Future<UserModel?> getCurrentUserData() async {
    final userData =
        await firestore.collection("users").doc(auth.currentUser?.uid).get();

    UserModel? userModel;

    if (userData.data() != null) {
      userModel = UserModel.fromMap(userData.data()!);
    }

    return userModel;
  }

  void signInWithPhone(
      BuildContext context, String phoneNumber, String phoneCode) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: "+$phoneCode$phoneNumber",
          verificationCompleted: (credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (error) {
            throw FirebaseAuthException(code: error.message!);
          },
          codeSent: (verificationId, resendToken) async {
            Navigator.of(context).pushNamed(OtpScreen.routeName, arguments: {
              "phoneCode": phoneCode,
              "phoneNumber": phoneNumber,
              "verificationId": verificationId
            });
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (ctx) => CustomAlertDialog(
              title: e.message!,
              buttonText: "OK",
              onPressed: () {
                Navigator.of(context).pop();
              }));
    }
  }

  void verifyOtp(
      BuildContext context, String verificationId, String otp) async {
    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      await auth.signInWithCredential(credential).then((value) =>
          Navigator.pushNamedAndRemoveUntil(
              context, UserInformationScreen.routeName, (route) => false));
    } on FirebaseAuthException catch (_) {
      showDialog(
          context: context,
          builder: (ctx) => CustomAlertDialog(
              title:
                  "The code you entered is incorrect. Please try again in 1 minute",
              buttonText: "OK",
              onPressed: () {
                Navigator.of(context).pop();
              }));
    }
  }

  void saveUserToDatabase(
      {required String name,
      required File? profilePic,
      required ProviderRef ref,
      required BuildContext context}) async {
    try {
      String userId = auth.currentUser!.uid;
      String photoUrl = defaultPhotoUrl;

      if (profilePic != null) {
        photoUrl = await ref
            .read(firebaseStorageRepositoryProvider)
            .storeFileToDatabase("profilePic/$userId", profilePic);
      }

      var user = UserModel(
          name: name,
          userId: userId,
          profilePic: photoUrl,
          isOnline: true,
          phoneNumber: auth.currentUser!.uid,
          groupId: []);

      await firestore.collection("users").doc(userId).set(user.toMap()).then(
          (_) => Navigator.pushNamedAndRemoveUntil(
              context, MobileScreenLayout.routeName, (route) => false));
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
