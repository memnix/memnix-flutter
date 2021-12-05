import 'package:memnix/main.dart';
import 'package:memnix/models/deck.dart';
import 'package:memnix/queries/get_deck.dart';
import 'package:memnix/screens/deck_play_screen.dart';
import 'package:memnix/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bar.dart';

class DecksPage extends StatelessWidget {
  final String jwt;

  const DecksPage({Key? key, required this.jwt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CardAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              DeckSection(jwt: jwt),
            ],
          ),
        ));
  }
}

class DeckSection extends StatefulWidget {
  final String jwt;

  const DeckSection({Key? key, required this.jwt}) : super(key: key);

  @override
  State<DeckSection> createState() => _DeckSectionState();
}

class _DeckSectionState extends State<DeckSection> {
  @override
  Widget build(BuildContext context) {
    Future<List<Deck>> futureDeck = attemptSubDecks(widget.jwt);

    return Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: FutureBuilder<List<Deck>>(
            future: futureDeck,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const Text("You are not sub to any deck!");
                }

                return Column(
                  children: snapshot.data!.map(
                    (deck) {
                      return MemnixDeck(deck, widget.jwt);
                    },
                  ).toList(),
                );
              } else if (snapshot.hasError) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomeScreen()));
              }
              return const CircularProgressIndicator();
            }));
  }
}

class MemnixDeck extends StatelessWidget {
  final String jwt;

  final Deck deckData;
  const MemnixDeck(this.deckData, this.jwt, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          currentDeck = deckData;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DeckPlayScreen(jwt: jwt,)));
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          height: 250,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(18)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 4,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                )
              ]),
          child: Column(
            children: [
              Container(
                height: 175,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                    ),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(deckData.banner))),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(deckData.deckName,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunito(
                              fontSize: 18, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 10),
                      Text(deckData.description,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunito(
                              fontSize: 14, fontWeight: FontWeight.w500))
                    ],
                  ))
            ],
          ),
        ));
  }
}
