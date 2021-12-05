import 'package:flutter/material.dart';
import 'package:Memnix/models/memcard.dart';
import 'package:Memnix/queries/get_card.dart';
import 'package:Memnix/screens/welcome_screen.dart';
import 'package:Memnix/widgets/today_widget.dart';

class NextCardWidget extends StatefulWidget {
  const NextCardWidget({Key? key, required this.jwt}) : super(key: key);
  final String jwt;

  @override
  _NextCardWidget createState() => _NextCardWidget();
}

class _NextCardWidget extends State<NextCardWidget> {
  get jwt => widget.jwt;
  late Future<MemCard> futureCard;

  @override
  Widget build(BuildContext context) {
    futureCard = attemptNextCardByDeck(jwt);
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder<MemCard>(
                future: futureCard,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data?.id == 0) {
                      return const Text(
                          "You don't have more cards to play today !");
                    }
                    return TodaysWidget(
                      card: snapshot.data,
                      jwt: jwt,
                      today: false
                    );
                  } else if (snapshot.hasError) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomeScreen()));
                  }
                  return const CircularProgressIndicator();
                })));
  }
}
