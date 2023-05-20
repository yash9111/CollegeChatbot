import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class chatWidget extends StatelessWidget {
  const chatWidget({super.key, required this.msg, required this.chatIndex});

  final String msg;
  final int chatIndex;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: chatIndex == 0 ? Colors.grey.shade200 : Colors.blueGrey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(chatIndex == 0
                    ? Icons.access_alarm_rounded
                    : Icons.yard_rounded),
                Expanded(
                    child: chatIndex == 0
                        ? Text(
                            msg,
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          )
                        : AnimatedTextKit(
                            isRepeatingAnimation: false,
                            animatedTexts: [
                                TypewriterAnimatedText(msg.trim())
                              ])),
              ],
            ),
          )
        ],
      ),
    );
  }
}
