import 'package:bot/gptGenerated.dart';
import 'package:bot/handle_popup.dart';
import 'package:flutter/material.dart';

import 'chatScreen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Server Request',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  PopupScreen());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String result = '';
  // var controller = TextEditingController();
  // String message = '';

  // void _handleButtonPress() {
  //   sendRequest(controller.text.toString()).then((value) {
  //     setState(() {
  //       result = '';
  //     });
  //     message = data_cleaner(value);
  //     wordToword(message);
  //   }).catchError((error) {
  //     setState(() {
  //       result = 'Error: $error';
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Server Request'),
      ),
      body: ChatGPTScreen(),
    );
  }

//   Center chatScreen() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           TextField(
//             controller: controller,
//             decoration: InputDecoration(hintText: "Say Something"),
//           ),
//           ElevatedButton(
//             onPressed: _handleButtonPress,
//             child: Text('Make Request'),
//           ),
//           SizedBox(height: 20),
//           Text(
//             'Result:',
//             style: TextStyle(fontSize: 20),
//           ),
//           Text(
//             result,
//             style: TextStyle(fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }

//   void wordToword(String message) {
//     for (int i = 0; i < message.length; i++) {
//       Future.delayed(Duration(seconds: 2));
//       setState(() {
//         result = result + message[i];
//       });
}
