import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> sendRequest(String message) async {
    var url = Uri.parse('http://127.0.0.1:5000/predict');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({'text': message});

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body)['result'];
      return result;
    } else {
      print('Request failed with status: ${response.statusCode}');
      throw Exception('Failed to connect to the server');
    }
  }