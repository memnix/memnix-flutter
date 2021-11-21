class Deck {
  final int id;
  final int banner;
  final String deckName;
  final String description;
  final int status;

  Deck(this.id, this.banner, this.deckName, this.description, this.status, );

  factory Deck.fromJson(Map<String, dynamic> json) {
    Deck deck = Deck(json["ID"], json["banner"], json["deck_name"],json["description"], json["status"]);
    return deck;
  }
}
