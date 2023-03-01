import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/contacts_info.dart';
import 'package:whatsapp_flutter/widgets/receiver_message_card.dart';
import 'package:whatsapp_flutter/widgets/sender_message_card.dart';

class ChatList extends StatelessWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: messages.length,
        itemBuilder: (ctx, index) {
          if (messages[index]["isMe"] == true) {
            return ReceiverMessageCard(
                message: messages[index]["text"].toString(),
                date: messages[index]["time"].toString());
          }
          return SenderMessageCard(
              message: messages[index]["text"].toString(),
              date: messages[index]["time"].toString());
        });
  }
}