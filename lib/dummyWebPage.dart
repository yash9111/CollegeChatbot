import 'package:flutter/material.dart';

class dummyScreen extends StatefulWidget {
  const dummyScreen({super.key});

  @override
  State<dummyScreen> createState() => _dummyScreenState();
}

class _dummyScreenState extends State<dummyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assest/bg.png'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
