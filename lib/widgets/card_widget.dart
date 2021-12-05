import 'package:flutter/material.dart';
import 'package:memnix/bar.dart';
import 'package:memnix/models/memcard.dart';
import 'package:memnix/queries/get_card.dart';
import 'package:memnix/screens/welcome_screen.dart';
import 'package:memnix/widgets/today_widget.dart';
import 'package:google_fonts/google_fonts.dart';

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
                      return Center(child: Text(
                          "You don't have more cards to play today !",
                          style: GoogleFonts.nunito(
                          fontSize: 26, fontWeight: FontWeight.w700)),);
                    }
                    return TodaysWidget(
                      card: snapshot.data,
                      jwt: jwt,
                      today: true
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
