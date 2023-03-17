import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_flutter/colors.dart';
import 'package:whatsapp_flutter/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_flutter/features/screens/login_screen.dart';
import 'package:whatsapp_flutter/features/screens/otp_screen.dart';
import 'package:whatsapp_flutter/features/screens/user_information_screen.dart';
import 'package:whatsapp_flutter/firebase_options.dart';
import 'package:whatsapp_flutter/screens/mobile_screen_layout.dart';
import 'package:whatsapp_flutter/utils/custom_error_screen.dart';
import 'package:whatsapp_flutter/utils/custom_loader.dart';

import 'features/screens/greeting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: "WhatsApp",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
          textSelectionTheme: const TextSelectionThemeData(
              cursorColor: tabColor,
              selectionColor: tabColor,
              selectionHandleColor: tabColor)),
      home: ref.watch(userDataAuthProvider).when(
          data: (userModel) {
            if (userModel == null) {
              return const GreetingScreen();
            }
            return const MobileScreenLayout();
          },
          error: (err, trace) {
            return ErrorScreen(content: err.toString());
          },
          loading: () => const Loader()),
      routes: {
        MobileScreenLayout.routeName: (_) => const MobileScreenLayout(),
        GreetingScreen.routeName: (_) => const GreetingScreen(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        OtpScreen.routeName: (_) => const OtpScreen(),
        UserInformationScreen.routeName: (_) => const UserInformationScreen(),
      },
    );
  }
}
