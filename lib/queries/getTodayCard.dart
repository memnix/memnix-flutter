import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:myapp/models/memcard.dart';

Future<MemCard> attemptTodayCard(dynamic jwt) async {
  var res = await http.get(
    Uri.parse('http://192.168.1.151:1813/api/v1/cards/today'),
    headers: {"Cookie": jwt},
  );
  if (res.statusCode == 200) {
    return MemCard.fromJson(jsonDecode(res.body)["data"]);
  } else {
    throw Exception('Failed to load card');
  }
}
