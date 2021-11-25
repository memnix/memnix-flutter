import 'dart:convert';
import 'package:Memnix/models/deck.dart';
import 'package:http/http.dart' as http;

Future<List<Deck>> attemptSubDecks(dynamic jwt) async {
  List<Deck> decks = [];
  var res = await http.get(
    Uri.parse('https://api-memnix.yumenetwork.net/api/v1/decks/sub'),
    headers: {"Cookie": jwt},
  );
  if (res.statusCode == 200) {
    int count = jsonDecode(res.body)["count"];
    for (var i = 0; i < count; i++) {
      decks.add(Deck.fromJson(jsonDecode(res.body)["data"][i]));
    }
    return decks;
  } else {
    throw Exception('Failed to load decks');
  }
}
