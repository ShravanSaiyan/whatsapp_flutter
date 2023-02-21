import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/colors.dart';

class WebSearchBar extends StatelessWidget {
  const WebSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.25,
      padding: const EdgeInsets.all(9),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: dividerColor))),
      child: TextField(
        decoration: InputDecoration(
            fillColor: searchBarColor,
            filled: true,
            prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.search),
            ),
            hintStyle: const TextStyle(fontSize: 14),
            hintText: "Search or start a new conversation",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide:
                    const BorderSide(width: 0, style: BorderStyle.none)),
            contentPadding: const EdgeInsets.all(10)),
      ),
    );
  }
}
