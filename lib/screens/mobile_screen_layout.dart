import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/colors.dart';

import '../widgets/contact_list.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: appBarColor,
            elevation: 0,
            title: const Text(
              "WhatsApp",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: false,
            actions: [
              IconButton(
                  onPressed: () {},
                  color: Colors.grey,
                  icon: const Icon(Icons.camera_alt_outlined)),
              IconButton(
                  onPressed: () {},
                  color: Colors.grey,
                  icon: const Icon(Icons.search_outlined)),
              IconButton(
                  onPressed: () {},
                  color: Colors.grey,
                  icon: const Icon(Icons.more_vert))
            ],
            bottom: const TabBar(
              indicatorColor: tabColor,
              indicatorWeight: 4,
              labelColor: tabColor,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              tabs: [
                Tab(text: "Chats"),
                Tab(text: "Status"),
                Tab(text: "Calls")
              ],
            ),
          ),
          body: const ContactList(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: tabColor,
            onPressed: () {},
            child: const Icon(
              Icons.chat,
              color: Colors.white,
            ),
          ),
        ));
  }
}
