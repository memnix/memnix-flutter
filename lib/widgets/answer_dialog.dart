import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/screens/main_screen.dart';

class AnswerDialog extends StatelessWidget {
  const AnswerDialog({Key? key, this.res, this.jwt}) : super(key: key);
  final dynamic res;
  final dynamic jwt;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: Text(jsonDecode(res!)["data"]["message"],
          style: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.w800)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                    builder: (context) => MainPage.fromBase64(jwt)));
          },
        )
      ],
    );
  }
}
