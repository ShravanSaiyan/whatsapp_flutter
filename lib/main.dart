import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/colors.dart';
import 'package:whatsapp_flutter/features/screens/login_screen.dart';
import 'package:whatsapp_flutter/firebase_options.dart';

import 'features/screens/greeting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "WhatsApp",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
          textSelectionTheme: const TextSelectionThemeData(
              cursorColor: tabColor,
              selectionColor: tabColor,
              selectionHandleColor: tabColor)),
      home: const GreetingScreen(),
      routes: {
        GreetingScreen.routeName: (_) => const GreetingScreen(),
        LoginScreen.routeName: (_) => const LoginScreen()
      },
    );
  }
}
