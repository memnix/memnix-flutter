import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/models/memcard.dart';

Future<String?> attemptPostAnswer(
    MemCard card, String answer, dynamic jwt) async {
  var res = await http.post(
      Uri.parse('http://192.168.1.151:1813/api/v1/cards/response'),
      headers: {"Content-Type": "application/json", "Cookie": jwt},
      body: json.encode({'card_id': card.id, 'response': answer}));
  if (res.statusCode == 200) {
    return res.body;
  }
  return null;
}
