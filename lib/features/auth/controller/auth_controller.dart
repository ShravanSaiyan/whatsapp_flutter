import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_flutter/features/auth/repository/auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository);
});

class AuthController {
  final AuthRepository authRepository;

  AuthController(this.authRepository);

  void signInWithPhone(
      BuildContext context, String phoneNumber, String phoneCode) {
    authRepository.signInWithPhone(context, phoneNumber, phoneCode);
  }

  void verifyOtp(BuildContext context, String verificationId, String otp) {
    authRepository.verifyOtp(context, verificationId, otp);
  }
}
