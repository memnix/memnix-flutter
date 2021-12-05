import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:memnix/models/user.dart';

Future<User> attemptUser(dynamic jwt) async {
  var res = await http.get(
    Uri.parse('https://api-memnix.yumenetwork.net/api/user'),
    headers: {"Cookie": jwt},
  );
  if (res.statusCode == 200) {
    return User.fromJson(jsonDecode(res.body));
  } else {
    return User(0, 0, "", "", "");
  }
}
