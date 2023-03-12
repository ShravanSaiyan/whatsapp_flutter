import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/colors.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback onPressed;

  const CustomAlertDialog(
      {Key? key,
      required this.title,
      required this.buttonText,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 16)),
      backgroundColor: senderMessageColor,
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(buttonText, style: const TextStyle(color: tabColor)),
        ),
      ],
    );
  }
}
