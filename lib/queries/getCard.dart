import 'dart:convert';
import 'package:Memnix/main.dart';
import 'package:http/http.dart' as http;

import 'package:Memnix/models/memcard.dart';

Future<MemCard> attemptTodayCard(dynamic jwt) async {
  var res = await http.get(
    Uri.parse('https://memnix.yumenetwork.net/api/v1/cards/today'),
    headers: {"Cookie": jwt},
  );
  if (res.statusCode == 200) {
    return MemCard.fromJson(jsonDecode(res.body)["data"]);
  } else {
    throw Exception('Failed to load card');
  }
}

Future<MemCard> attemptNextCardByDeck(dynamic jwt) async {
  var res = await http.get(
    Uri.parse(
        'https://memnix.yumenetwork.net/api/v1/cards/${currentDeck.id}/next'),
    headers: {"Cookie": jwt},
  );
  if (res.statusCode == 200) {
    return MemCard.fromJson(jsonDecode(res.body)["data"]);
  } else {
    throw Exception('Failed to load card');
  }
}
