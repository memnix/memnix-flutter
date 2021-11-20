import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:Memnix/models/memcard.dart';

Future<String?> attemptPostAnswer(
    MemCard card, String answer, dynamic jwt) async {
  var res = await http.post(
      Uri.parse('https://memnix.yumenetwork.net/api/v1/cards/response'),
      headers: {"Content-Type": "application/json", "Cookie": jwt},
      body: json.encode({'card_id': card.id, 'response': answer}));
  if (res.statusCode == 200) {
    return res.body;
  }  
  return null;
}
