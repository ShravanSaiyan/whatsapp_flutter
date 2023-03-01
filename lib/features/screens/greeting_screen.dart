import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_flutter/colors.dart';
import 'package:whatsapp_flutter/features/screens/login_screen.dart';

class GreetingScreen extends StatelessWidget {
  static const String routeName = "/greeting";

  const GreetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 370,
              width: 290,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("assets/images/bg.jpg"),
                      fit: BoxFit.fill)),
            ),
            const SizedBox(
              height: 15,
            ),
            const Align(
              child: Text(
                "Welcome to WhatsApp",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    const TextSpan(
                        text: "Read our ",
                        style: TextStyle(color: Colors.grey)),
                    TextSpan(
                        text: "Privacy Policy.",
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            const url =
                                "https://whatsapp.com/legal/privacy-policy";
                            await launchUrl(Uri.parse(url));
                          }),
                    const TextSpan(
                        text: ' Tap "Agree and Continue" to \naccept the ',
                        style: TextStyle(color: Colors.grey)),
                    TextSpan(
                        text: "Terms of Service.",
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            const url =
                                "https://whatsapp.com/legal/privacy-policy";
                            await launchUrl(Uri.parse(url));
                          }),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: size.width * 0.75,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: tabColor,
                      minimumSize: const Size(double.infinity, 50)),
                  onPressed: () {
                    Navigator.of(context).pushNamed(LoginScreen.routeName);
                  },
                  child: const Text(
                    "AGREE AND CONTINUE",
                    style: TextStyle(color: Colors.black),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
