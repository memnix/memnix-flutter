class Deck {
  final int id;
  final String banner;
  final String deckName;
  final String description;
  final int status;

  Deck(this.id, this.banner, this.deckName, this.description, this.status, );

  factory Deck.fromJson(Map<String, dynamic> json) {
    Deck deck = Deck(json["ID"], json["deck_banner"], json["deck_name"],json["deck_description"], json["deck_status"]);
    return deck;
  }

}
