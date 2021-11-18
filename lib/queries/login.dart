import 'dart:convert';

import 'package:http/http.dart' as http;


Future<String?> attemptLogIn(String email, String password) async {
  var res = await http.post(Uri.parse('https://memnix.yumenetwork.net/api/login'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({'email': email.toLowerCase(), 'password': password}));
  if (res.statusCode == 200) {
    var cookie = res.headers['set-cookie'];
    return cookie;
  }
  return null;
}