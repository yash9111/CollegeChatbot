// ignore_for_file: prefer_const_constructors

import 'package:bot/Server/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Structure/data_cleaner.dart';
import '../Structure/messages.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isTyping = false;
  String result = '';
  var controller = TextEditingController();
  String message = '';
  bool isAnimating = false;
  List<Message> chatMessages = [];
  Message m = Message(isBot: 1, text: "Hey , welcome to ITM.");
  String enteredMessag = "";
  void _handleButtonPress() {
    String recivedMessage = controller.text.toString();
    Message userMessageObj = Message(isBot: 0, text: recivedMessage);

    setState(() {
      chatMessages.add(userMessageObj);
      isTyping = false;
    });
    isTyping = true;
    sendRequest(enteredMessag).then((value) {
      setState(() {
        controller.clear();
        result = '';
      });
      message = data_cleaner(value);
      // message = value;
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
    print(message);
  }

  @override
  void initState() {
    chatMessages.add(m);
    chatMessages.add(Message(
        isBot: 1,
        text:
            "You can ask me about many things such as ....\n1.Admission process\n2.Documents Required\n3.Placements\n4.About college\n5.Branches available",
        avatar: false));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 141, 39, 41),
        title: Center(
          child: Text(
            "Institute of Technology and Management",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                Message message = chatMessages[index];
                return Align(
                  alignment: chatMessages[index].isBot == 1
                      ? Alignment.topLeft
                      : Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: message.isBot == 1
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (message.isBot == 1) ...[
                        message.avatar
                            ? CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    AssetImage('assest/images/itmLogo.png'),
                              )
                            : SizedBox(
                                width: 38,
                              ),
                        SizedBox(width: 8.0),
                      ],
                      // CircleAvatar(
                      //   backgroundImage: chatMessages[index].isBot == 1
                      //       ? AssetImage('assest/botImage.gif')
                      //       : AssetImage('assest/user.gif'),
                      // ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 400, // Set maximum width
                          minWidth: 80, // Set minimum width
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: chatMessages[index].isBot == 1
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade300,
                            ),
                            padding: EdgeInsets.all(8),
                            child: Text(
                              message.text,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      if (message.isBot == 0) ...[
                        SizedBox(width: 8.0),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage:
                              AssetImage('assest/images/userImage.jpg'),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          if (isTyping) ...[
            // SpinKitHourGlass(
            //   color: Colors.red,
            //   size: 20,
            // ),
            AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: isTyping ? 1.0 : 0.0,
              child: SpinKitThreeBounce(
                color: Colors.red,
                size: 20,
              ),
            ),
          ],
          RawKeyboardListener(
            focusNode: FocusNode(),
            // onKey: _handleKeyboardEvent,
            child: Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      contentPadding: EdgeInsets.all(16),
                      border: InputBorder.none,
                    ),
                    textInputAction: TextInputAction.send,
                    autofocus: true,
                    minLines: 1,
                    maxLines: 10,
                    onSubmitted: (value) {
                      if (controller.text.toString() == "1") {
                        enteredMessag = "Tell me about Admission Process";
                      } else if (controller.text.toString() == "2") {
                        enteredMessag =
                            "Documents required for admission process";
                      } else if (controller.text.toString() == "3") {
                        enteredMessag = "What about the placement in itm ";
                      } else if (controller.text.toString() == "4") {
                        enteredMessag = "Tell me something about itm ";
                      } else if (controller.text.toString() == "5") {
                        enteredMessag =
                            "What are the branches available in itm";
                      } else {
                        enteredMessag = controller.text.toString();
                      }
                      _handleButtonPress();
                      controller.clear();
                    },
                  )),
                  Column(
                    children: [
                      Container(
                        width:
                            40, // Set the width and height as per your requirement
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.6), // Shadow color
                              spreadRadius: 5, // Spread radius
                              blurRadius: 6, // Blur radius
                              offset:
                                  Offset(0, 3), // Offset in x and y direction
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 141, 39, 41),
                          child: IconButton(
                            icon: Icon(Icons.send),
                            color: Colors.white,
                            onPressed: () {
                              _handleButtonPress();
                              controller.clear();
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  // ElevatedButton(
                  //     onPressed: _handleButtonPress, child: Icon(Icons.send))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
