import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_flutter/features/auth/controller/auth_controller.dart';

import '../../colors.dart';

class OtpScreen extends ConsumerWidget {
  static const String routeName = "/otp-screen";

  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginDetails =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    final countryCode = loginDetails["phoneCode"];
    final phoneNumber = loginDetails["phoneNumber"];
    final verificationId = loginDetails["verificationId"];

    void verifyOtp(BuildContext context, String verificationId, String otp) {
      ref.read(authControllerProvider).verifyOtp(context, verificationId, otp);
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            "Enter your phone number",
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          PopupMenuButton(
            color: searchBarColor,
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            itemBuilder: (_) => [
              const PopupMenuItem(
                padding: EdgeInsets.only(left: 10.0, right: 136.0),
                height: 29.0,
                value: "Help",
                child: Text("Help"),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Waiting to automatically detect an SMS sent to\n",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  TextSpan(
                    text: "+$countryCode\t$phoneNumber.\t",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text: "Wrong number?",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pop();
                        })
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: tabColor, width: 2.0)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: tabColor, width: 2.0)),
                  hintText: "- - - \t\t- - -",
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.w900, fontSize: 30)),
              keyboardType: TextInputType.phone,
              onTapOutside: (_) {
                FocusScope.of(context).unfocus();
              },
              onChanged: (otp) {
                if (otp != null && otp.isNotEmpty && otp.length == 6) {
                  verifyOtp(context, verificationId!, otp);
                }
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              "Enter 6-digit code",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const Text(
            "Did not receive code?",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
