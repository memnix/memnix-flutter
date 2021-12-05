import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:memnix/main.dart';

Future<String?> attemptLogIn(String email, String password) async {
  var res = await http.post(
      Uri.parse('https://api-memnix.yumenetwork.net/api/login'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({'email': email.toLowerCase(), 'password': password}));
  if (res.statusCode == 200) {
    var cookie = res.headers['set-cookie'];
    return cookie;
  }
  return null;
}

Future<String?> attemptLogout() async {
  var res = await http.post(
      Uri.parse('https://api-memnix.yumenetwork.net/api/logout'),
      headers: {"Content-Type": "application/json"});
  if (res.statusCode == 200) {
    var cookie = res.headers['set-cookie'];
    secureStorage.deleteSecureData("jwt");
    return cookie;
  }
  return null;
}
