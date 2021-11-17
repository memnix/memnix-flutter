import 'package:flutter/material.dart';
import 'package:myapp/bar.dart';
import 'package:myapp/models/memcard.dart';
import 'package:myapp/queries/getTodayCard.dart';
import 'package:myapp/widgets/today_widget.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({Key? key, required this.jwt}) : super(key: key);
  final String jwt;

  @override
  _CardWidget createState() => _CardWidget();
}

class _CardWidget extends State<CardWidget> {
  get jwt => widget.jwt;
  late Future<MemCard> futureCard;

  @override
  Widget build(BuildContext context) {
    futureCard = attemptTodayCard(jwt);
    return Scaffold(
        appBar: const CardAppBar(),
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
                    );
                  } else if (snapshot.hasError) {
                    return const Text(
                        "You don't have more cards to play today !");
                  }
                  return const CircularProgressIndicator();
                })));
  }
}
