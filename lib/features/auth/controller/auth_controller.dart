import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_flutter/features/auth/repository/auth_repository.dart';

import '../../../models/user.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository, ref);
});

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef providerRef;

  AuthController(this.authRepository, this.providerRef);

  Future<UserModel?> getUserData() async {
    final userModel = await authRepository.getCurrentUserData();
    return userModel;
  }

  void signInWithPhone(
      BuildContext context, String phoneNumber, String phoneCode) {
    authRepository.signInWithPhone(context, phoneNumber, phoneCode);
  }

  void verifyOtp(BuildContext context, String verificationId, String otp) {
    authRepository.verifyOtp(context, verificationId, otp);
  }

  void saveUserToDatabase(String name, File? profilePic, BuildContext context) {
    authRepository.saveUserToDatabase(
        name: name, profilePic: profilePic, ref: providerRef, context: context);
  }
}
