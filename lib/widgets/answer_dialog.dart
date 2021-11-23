import 'dart:convert';
import 'package:Memnix/screens/deck_play_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Memnix/screens/main_screen.dart';

class AnswerDialog extends StatelessWidget {
  const AnswerDialog(
      {Key? key, required this.res, required this.jwt, required this.today})
      : super(key: key);
  final dynamic res;
  final dynamic jwt;
  final bool today;

  @override
  Widget build(BuildContext context) {
    MaterialColor color;
    if (jsonDecode(res!)["data"]["validate"] == true) {
      color = Colors.green;
    } else {
      color = Colors.red;
    }
    return AlertDialog(
      title: Text(jsonDecode(res!)["data"]["message"],
          style: GoogleFonts.nunito(
              fontSize: 22, fontWeight: FontWeight.w800, color: color)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      content: Text(
          "Expected  answer: ${jsonDecode(res)["data"]['correct_answer']}",
          style: GoogleFonts.lexendDeca(
              fontSize: 20, fontWeight: FontWeight.w500)),
      actions: [
        ElevatedButton(
          child: const Text("Continue"),
          onPressed: () {
            if (today) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainPage.fromBase64(jwt)));
            } else {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DeckPlayScreen(
                            jwt: jwt,
                          )));
            }
          },
        )
      ],
    );
  }
}
