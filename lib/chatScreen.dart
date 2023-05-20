import 'package:bot/chat_widget.dart';
import 'package:bot/constants.dart';
import 'package:bot/server.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'data_cleaner.dart';
import 'messages.dart';

class chatScreen extends StatefulWidget {
  const chatScreen({super.key});

  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  bool isTyping = false;
  String result = '';
  var controller = TextEditingController();
  String message = '';
  List<Message> chatMessages = [];

  void _handleButtonPress() {
    String recivedMessage = controller.text.toString();
    Message userMessageObj = Message(isBot: 0, text: recivedMessage);

    setState(() {
      chatMessages.add(userMessageObj);
    });

    isTyping = true;
    sendRequest(controller.text.toString()).then((value) {
      setState(() {
        result = '';
      });
      message = data_cleaner(value);
      result = message;
      setState(() {
        chatMessages.add(Message(isBot: 1, text: result));
        isTyping = false;
      });
    }).catchError((error) {
      setState(() {
        isTyping = false;
        result = 'Error: $error';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TextEditingController controller = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        leading: Icon(Icons.ac_unit_outlined),
        title: Text("ITM"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Flexible(
              child: ListView.builder(
            itemBuilder: (context, index) {
              return chatWidget(
                msg: chatMessages[index].text,
                chatIndex: (chatMessages[index].isBot),
                //  msg: chatMessages[index],
              );
            },
            itemCount: chatMessages.length,
          )),
          if (isTyping) ...[
            SpinKitChasingDots(
              color: Colors.red,
              size: 20,
            ),
          ],
          Row(
            children: [
              Expanded(
                  child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    hintText: "Please type here ",
                    hintStyle: TextStyle(color: Colors.black, fontSize: 20)),
              )),
              IconButton(
                onPressed: () {
                  _handleButtonPress();
                  setState(() {});
                },
                icon: Icon(Icons.send),
              )
            ],
          )
        ],
      )),
    );
  }

  Scaffold demoScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(hintText: "Say Something"),
            ),
            ElevatedButton(
              onPressed: _handleButtonPress,
              child: Text('Make Request'),
            ),
            SizedBox(height: 20),
            Text(
              'Result:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              result,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
