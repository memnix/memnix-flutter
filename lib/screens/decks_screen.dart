import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bar.dart';

class DecksPage extends StatelessWidget {
  const DecksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              DeckSection(),
            ],
          ),
        ));
  }
}

class DeckSection extends StatelessWidget {
  final List deckList = [
    {
      'deck_name': "What's the answer to life ?",
      'description': "42",
      'banner':
          'https://static.pix-geeks.com/2016/07/h2g2-le-guide-du-voyageur-galactique-24917.jpg'
    },
    {
      'deck_name': "What's the answer to life ?",
      'description': "42",
      'banner':
          'https://static.pix-geeks.com/2016/07/h2g2-le-guide-du-voyageur-galactique-24917.jpg'
    },
    {
      'deck_name': "What's the answer to life ?",
      'description': "42",
      'banner':
          'https://static.pix-geeks.com/2016/07/h2g2-le-guide-du-voyageur-galactique-24917.jpg'
    },
    {
      'deck_name': "What's the answer to life ?",
      'description': "42",
      'banner':
          'https://static.pix-geeks.com/2016/07/h2g2-le-guide-du-voyageur-galactique-24917.jpg'
    },
    {
      'deck_name': "What's the answer to life ?",
      'description': "42",
      'banner':
          'https://static.pix-geeks.com/2016/07/h2g2-le-guide-du-voyageur-galactique-24917.jpg'
    },
    {
      'deck_name': "What's the answer to life ?",
      'description': "42",
      'banner':
          'https://static.pix-geeks.com/2016/07/h2g2-le-guide-du-voyageur-galactique-24917.jpg'
    },
  ];

  DeckSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Column(
        children: deckList.map(
          (deck) {
            return MemnixCard(deck);
          },
        ).toList(),
      ),
    );
  }
}

class MemnixCard extends StatelessWidget {
  final Map cardData;
  const MemnixCard(this.cardData, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                  title: Text("Memnix Alpha"),
                  content: Text(
                      "Router to deck page")));
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
                        image: NetworkImage(cardData["banner"]))),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(cardData["deck_name"],
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunito(
                              fontSize: 18, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 10),
                      Text(cardData["description"],
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
