class MemCard {
  final String question;
  final String imageUrl;
  final int id;
  late String response0;
  late String response1;
  late String response2;
  late String response3;
  final int type;
  final String format;

  MemCard(
    this.response0,
    this.response1,
    this.response2,
    this.response3, {
    required this.question,
    required this.type,
    required this.id,
    required this.imageUrl,
    required this.format,
  });

  factory MemCard.fromJson(Map<String, dynamic> json) {
    var card = MemCard(
      '',
      '',
      '',
      '',
      type: json["Card"]["card_type"],
      id: json["Card"]["ID"],
      imageUrl: json["Card"]["card_image"],
      question: json["Card"]["card_question"],
      format: json["Card"]["card_format"],
    );
    if (json["Card"]["card_type"] == 2) {
      card.response0 = json["Answers"][0];
      card.response1 = json["Answers"][1];
      card.response2 = json["Answers"][2];
      card.response3 = json["Answers"][3];
    } else {
      card.response0 = json["Card"]["card_answer"];
    }

    return card;
  }
}
