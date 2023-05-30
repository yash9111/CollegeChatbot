// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bot/chat_widget.dart';
import 'package:bot/constants.dart';
import 'package:bot/feedform_screen.dart';
import 'package:bot/gptGenerated.dart';
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
    return mainScreenModel();
  }

  Scaffold mainScreenModel() {
    return Scaffold(
      backgroundColor: Color.fromRGBO(50, 41, 41, 100),
      appBar: AppBar(
        // leading: Icon(
        //   Icons.ac_unit_outlined,
        //   color: Colors.blue,
        // ),
        // ignore: prefer_const_constructors
        title: Center(
          child: Text(
            "Institute of Technology and Management",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),

        backgroundColor: Colors.black,

        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle menu item selection here
              if (value == 'menu_option_1') {
                // Do something for menu option 1
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return FeedbackForm();
                  },
                ));
              } else if (value == 'menu_option_2') {
                // Do something for menu option 2
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'menu_option_1',
                child: Text('Feedback'),
              ),
              PopupMenuItem<String>(
                value: 'menu_option_2',
                child: Text('About us'),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: SafeArea(
            child: Column(
          children: [
            Flexible(
                child: ListView.builder(
              itemBuilder: (context, index) {
                return Align(
                  alignment: chatMessages[index].isBot ==0 ? Alignment.topLeft:Alignment.topRight,
                  child: chatWidget(
                    msg: chatMessages[index].text,
                    chatIndex: (chatMessages[index].isBot),
                    //  msg: chatMessages[index],
                  ),
                );
              },
              itemCount: chatMessages.length,
            )),
            if (isTyping) ...[
              SpinKitDualRing(
                color: Colors.red,
                size: 20,
              ),
            ],
            SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Expanded(
                        child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      // maxLength: 1000,
                      minLines: 1,
                      autofillHints: ["Hey", "Hello", "How are you"],
                      cursorColor: Colors.black,
                      controller: controller,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      onSubmitted: (value) {
                        _handleButtonPress();
                        controller.clear();
                      },
                      decoration: InputDecoration(
                          // enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(
                          //       width: 0,
                          //       color: Colors.blue,
                          //     ),
                          //     borderRadius: BorderRadius.circular(10)),
                          hintText: "Please type here ",
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 20),
                          filled: true,
                          contentPadding: EdgeInsets.fromLTRB(10.0, 0, 50, 0),
                          fillColor: Colors.white),
                      textInputAction: TextInputAction.send,
                      autofocus: true,
                    )),
                  ),
                  Positioned(
                    top: 10,
                    right: 20,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: IconButton(
                          onPressed: () {
                            _handleButtonPress();
                            controller.clear();
                            setState(() {});
                          },
                          icon: Icon(Icons.send)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        )),
      ),
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
