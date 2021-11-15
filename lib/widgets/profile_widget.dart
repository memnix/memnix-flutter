import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bar.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const CardAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProfileSection(),
            ],
          ),
        ));
  }
}

class ProfileSection extends StatelessWidget {
  final card = [
    {
      'question': "Username",
      'image_url':
          "https://www.auctionlab.news/wp-content/uploads/2020/11/Antoine-DE-SAINT-EXUPERY-dapres-Le-Petit-Prince-en-costume-2009-Lithographie-auctionlab-0.jpg"
    },
  ];

  ProfileSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Column(children: [
        ProfileCard(card[0]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Friends: 3",
                style: GoogleFonts.nunito(
                    fontSize: 18, fontWeight: FontWeight.w500)),
            Text("Decks: 6",
                style: GoogleFonts.nunito(
                    fontSize: 18, fontWeight: FontWeight.w500))
          ],
        )
      ]),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final cardData;
  const ProfileCard(this.cardData, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 400,
      child: Column(
        children: [
          Container(
            height: 350,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
                image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(cardData["image_url"]))),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(cardData["question"],
                      style: GoogleFonts.nunito(
                          fontSize: 22, fontWeight: FontWeight.w800)),
                ],
              ))
        ],
      ),
    );
  }
}
