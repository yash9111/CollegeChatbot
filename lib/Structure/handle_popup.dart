import 'package:bot/Screens/FinalChatScreen.dart';
import 'package:bot/Screens/chatScreen.dart';
import 'package:bot/Screens/dummyWebPage.dart';
import 'package:flutter/material.dart';

class PopupScreen extends StatefulWidget {
  @override
  _PopupScreenState createState() => _PopupScreenState();
}

class _PopupScreenState extends State<PopupScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _scaleAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _togglePopup() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final popupHeight = screenHeight * 0.9;

    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          // Background content
          dummyScreen(),

          // Popup screen
          Positioned(
            left: screenWidth * 0.5, // Starting from 25% of the screen width
            right: screenWidth * 0.09, // Ending at 25% of the screen width
            top: _isOpen ? (screenHeight - popupHeight) / 2 : screenHeight,
            height: popupHeight,
            // width: 500,
            child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  // color: Colors.blue,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ]),

                  child: ChatScreen(),
                )),
          ),

          // Floating action button
          Positioned(
            right: 50,
            bottom: 50,
            child: Tooltip(
              message: "How can i help you ?",
              textStyle: TextStyle(color: Colors.black),
              preferBelow: false,
              excludeFromSemantics: true,
              height: 30,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade300,
              ),
              child: FloatingActionButton(
                onPressed: _togglePopup,
                backgroundColor: Color.fromARGB(255, 141, 39, 41),
                child: Icon(Icons.chat),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
