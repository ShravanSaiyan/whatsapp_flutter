import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/colors.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var initialCountryName = "India";
  var initialCountryCode = "91";
  final phoneNumberController = TextEditingController();
  Country? country;

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
                                  ? country!.countryCode
                                  : initialCountryCode,
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
                onPressed: () {},
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
