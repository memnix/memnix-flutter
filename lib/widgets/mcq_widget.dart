import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/models/memcard.dart';
import 'package:myapp/queries/postAnswer.dart';
import 'package:myapp/screens/main_screen.dart';

class McqButtonWidget extends StatefulWidget {
  final String answer;
  final MemCard card;
  final dynamic jwt;

  const McqButtonWidget(this.answer, this.card, this.jwt, {Key? key})
      : super(key: key);

  @override
  _McqButtonWidget createState() => _McqButtonWidget();
}

class _McqButtonWidget extends State<McqButtonWidget> {
  get answer => widget.answer;
  get card => widget.card;
  get jwt => widget.jwt;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        String? res = await attemptPostAnswer(card, answer, jwt);
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  title: Text(jsonDecode(res!)["data"]["message"],
                      style: GoogleFonts.nunito(
                          fontSize: 22, fontWeight: FontWeight.w800)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  content: Text(
                      "Expected  answer: ${jsonDecode(res)["data"]['correct_answer']}",
                      style: GoogleFonts.lexendDeca(
                          fontSize: 20, fontWeight: FontWeight.w500)),
                  actions: [
                    ElevatedButton(
                      child: const Text("Continue"),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MainPage.fromBase64(jwt)));
                      },
                    )
                  ],
                ));
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.lightBlue[400],
        onPrimary: Colors.white,
        onSurface: Colors.blueAccent,
        elevation: 20,
        minimumSize: const Size(270, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        answer,
        style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w800),
      ),
    );
  }
}
