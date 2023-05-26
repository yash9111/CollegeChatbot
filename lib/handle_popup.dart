import 'package:bot/chatScreen.dart';
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
      duration: Duration(milliseconds: 300),
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
          Container(
            color: Colors.white, // Replace with your desired background color
          ),

          // Popup screen
          Positioned(
            left: screenWidth * 0.25, // Starting from 25% of the screen width
            right: screenWidth * 0.25, // Ending at 25% of the screen width
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

                  child: chatScreen(),
                )),
          ),

          // Floating action button
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: _togglePopup,
              child: Icon(Icons.chat),
            ),
          ),
        ],
      ),
    );
  }
}
