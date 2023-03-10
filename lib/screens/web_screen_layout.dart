import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/widgets/chat_list.dart';
import 'package:whatsapp_flutter/widgets/contact_list.dart';
import 'package:whatsapp_flutter/widgets/web_chat_app_bar.dart';
import 'package:whatsapp_flutter/widgets/web_chat_input_box.dart';
import 'package:whatsapp_flutter/widgets/web_profile_bar.dart';
import 'package:whatsapp_flutter/widgets/web_search_bar.dart';

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: const [WebProfileBar(), WebSearchBar(), ContactList()],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("images/backgroundImage.png"))),
          child: Column(
            children: const [
              WebChatAppBar(),
              Expanded(child: ChatList()),
              WebChatInputBox()
              // Message Input Box
            ],
          ),
        )
      ],
    ));
  }
}
