import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/queries/login.dart';
import 'package:myapp/screens/welcome_screen.dart';

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
    Size size = MediaQuery.of(context).size;

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
                    fontSize: 18, fontWeight: FontWeight.w500)),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
            height: size.height * 0.08,
            width: size.width * 0.8,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.red,
                onSurface: Colors.red,
                elevation: 20,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () async {
                var _ = await attemptLogout();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WelcomeScreen()));
              },
              child: Text(
                "Logout",
                style: GoogleFonts.lexendDeca(
                    color: Colors.white, fontSize: 30, height: 1.5),
              ),
            ))
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
