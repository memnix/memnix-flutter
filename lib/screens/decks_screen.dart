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
              CardSection(),
            ],
          ),
        ));
  }
}

class CardSection extends StatelessWidget {
  final List cardList = [
    {
      'question': "What's the answer to life ?",
      'response': "42",
      'image_url':
          "https://images.pexels.com/photos/462118/pexels-photo-462118.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
    },
    {
      'question': "What's the answer to life ?",
      'response': "42",
      'image_url':
          'https://static.pix-geeks.com/2016/07/h2g2-le-guide-du-voyageur-galactique-24917.jpg'
    },
    {
      'question': "What's the answer to life ?",
      'response': "42",
      'image_url':
          "https://static.pix-geeks.com/2016/07/h2g2-le-guide-du-voyageur-galactique-24917.jpg"
    },
    {
      'question': "What's the answer to life ?",
      'response': "42",
      'image_url':
          'https://static.pix-geeks.com/2016/07/h2g2-le-guide-du-voyageur-galactique-24917.jpg'
    },
    {
      'question': "What's the answer to life ?",
      'response': "42",
      'image_url':
          'https://static.pix-geeks.com/2016/07/h2g2-le-guide-du-voyageur-galactique-24917.jpg'
    },
    {
      'question': "What's the answer to life ?",
      'response': "42",
      'image_url':
          'https://static.pix-geeks.com/2016/07/h2g2-le-guide-du-voyageur-galactique-24917.jpg'
    },
    {
      'question': "What's the answer to life ?",
      'response': "42",
      'image_url':
          'https://static.pix-geeks.com/2016/07/h2g2-le-guide-du-voyageur-galactique-24917.jpg'
    },
  ];

  CardSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Column(
        children: cardList.map(
          (card) {
            return MemnixCard(card);
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
    return Container(
      margin: const EdgeInsets.all(10),
      height: 230,
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
            height: 140,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(cardData["image_url"]))),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(cardData["question"],
                      style: GoogleFonts.nunito(
                          fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  Text(cardData["response"],
                      style: GoogleFonts.nunito(
                          fontSize: 18, fontWeight: FontWeight.w800))
                ],
              ))
        ],
      ),
    );
  }
}
