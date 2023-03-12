import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_flutter/colors.dart';
import 'package:whatsapp_flutter/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String routeName = "/login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  var initialCountryName = "India";
  var initialCountryPhoneCode = "91";
  final phoneNumberController = TextEditingController();
  Country? country;
  bool isValid = false;

  @override
  void dispose() {
    super.dispose();
    phoneNumberController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        showPhoneCode: true,
        onSelect: (countryValue) {
          setState(() {
            country = countryValue;
          });
        });
  }

  String? _validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      isValid = false;
      return "Please enter the phone number.";
    } else if (phoneNumber.length < 10) {
      isValid = false;
      return "The phone number you entered is too short";
    }
    isValid = true;
    return null;
  }

  void _showDialog(String phoneNumber) {
    final errorMessage = _validatePhoneNumber(phoneNumber);

    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: senderMessageColor,
            content: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: isValid
                          ? "You entered the phone number:\n\n"
                          : errorMessage,
                      style: const TextStyle(color: Colors.grey, fontSize: 16)),
                  if (isValid)
                    TextSpan(
                        text:
                            "+${country != null ? country!.phoneCode : initialCountryPhoneCode}\t$phoneNumber\n\n",
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 16)),
                  if (isValid)
                    const TextSpan(
                        text:
                            "Is this OK, or would you like to edit the number?",
                        style: TextStyle(color: Colors.grey, fontSize: 16)),
                ],
              ),
            ),
            actions: [
              if (isValid)
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "EDIT",
                      style: TextStyle(color: tabColor),
                    )),
              TextButton(
                  onPressed: () {
                    if (isValid) {
                      sendPhoneNumber();
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(color: tabColor),
                  )),
            ],
            actionsAlignment: isValid
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.end,
          );
        });
  }

  void sendPhoneNumber() {
    ref.read(authControllerProvider).signInWithPhone(
        context, phoneNumberController.text.trim(), country!.phoneCode);
  }

  @override
  Widget build(BuildContext context) {
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Whatsapp will need to verify your phone number.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.60,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1.0, color: tabColor))),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    InkWell(
                        onTap: pickCountry,
                        child: Align(
                          child: Text(
                            country != null
                                ? country!.name
                                : initialCountryName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                        )),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: tabColor,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.17,
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 1.0, color: tabColor))),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              country != null
                                  ? country!.phoneCode
                                  : initialCountryPhoneCode,
                              style: const TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: TextField(
                        textAlign: TextAlign.start,
                        textAlignVertical: const TextAlignVertical(y: 1.0),
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: tabColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: tabColor)),
                          hintText: "phone number",
                        ),
                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        onTapOutside: (_) {
                          FocusScope.of(context).unfocus();
                        },
                        onSubmitted: (phoneNumber) => _showDialog(phoneNumber),
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  "Carrier charges may apply",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: ElevatedButton(
                onPressed: () => _showDialog(phoneNumberController.text),
                style: ElevatedButton.styleFrom(
                  backgroundColor: tabColor,
                ),
                child: const Text(
                  "NEXT",
                  style: TextStyle(color: Colors.black),
                )),
          )
        ],
      ),
    );
  }
}
