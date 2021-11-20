import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Memnix/models/user.dart';
import 'package:Memnix/queries/login.dart';
import 'package:Memnix/queries/user.dart';
import 'package:Memnix/screens/welcome_screen.dart';

import '../bar.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key, required this.jwt}) : super(key: key);
  final String jwt;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late Future<User> futureUser;

  get jwt => widget.jwt;

  @override
  Widget build(BuildContext context) {
    futureUser = attemptUser(jwt);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const CardAppBar(),
        body: SingleChildScrollView(
          child: FutureBuilder<User>(
              future: futureUser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data?.id == 0) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomeScreen()));
                  }
                  return ProfileSection(user: snapshot.data);
                }
                return const Text("Can't find user's info");
                // return const CircularProgressIndicator();
              }),
        ));
  }
}

class ProfileSection extends StatelessWidget {
  final User? user;

  const ProfileSection({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Column(children: [
        ProfileCard(user!),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Friends: 0",
                style: GoogleFonts.nunito(
                    fontSize: 18, fontWeight: FontWeight.w500)),
            Text("Decks: 1",
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
                        builder: (context) => const WelcomeScreen()));
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
  final User user;
  const ProfileCard(this.user, {Key? key}) : super(key: key);
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
                    image: NetworkImage(user.avatarUrl))),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(user.userName,
                      style: GoogleFonts.nunito(
                          fontSize: 22, fontWeight: FontWeight.w800)),
                ],
              ))
        ],
      ),
    );
  }
}
