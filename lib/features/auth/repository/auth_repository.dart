import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_flutter/features/screens/otp_screen.dart';
import 'package:whatsapp_flutter/features/screens/user_information_screen.dart';
import 'package:whatsapp_flutter/utils/custom_alert_dialog.dart';

final authRepositoryProvider = Provider((reference) =>
    AuthRepository(FirebaseAuth.instance, FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository(this.auth, this.firestore);

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
              title: e.message!, buttonText: "OK", onPressed: () {}));
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
}

