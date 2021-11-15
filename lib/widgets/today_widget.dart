import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/models/memcard.dart';
import 'package:myapp/queries/postAnswer.dart';
import 'package:myapp/screens/main_screen.dart';
import 'package:myapp/widgets/mcq_widget.dart';
import 'package:myapp/widgets/question_widget.dart';

class TodaysWidget extends StatefulWidget {
  final MemCard? card;
  final dynamic jwt;

  const TodaysWidget({Key? key, required this.card, required this.jwt})
      : super(key: key);

  @override
  State<TodaysWidget> createState() => _TodaysWidgetState();
}

class _TodaysWidgetState extends State<TodaysWidget> {
  final TextEditingController textController = TextEditingController();

  showWidget(MemCard card, dynamic context) {
    if (card.type == 2) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            McqButtonWidget(card.response0, card, widget.jwt),
            const Padding(padding: EdgeInsets.all(10.0)),
            McqButtonWidget(card.response1, card, widget.jwt),
            const Padding(padding: EdgeInsets.all(10.0)),
            McqButtonWidget(card.response2, card, widget.jwt),
            const Padding(padding: EdgeInsets.all(10.0)),
            McqButtonWidget(card.response3, card, widget.jwt),
          ]);
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Padding(padding: EdgeInsets.all(15.0)),
          TextField(
            controller: textController,
            textInputAction: TextInputAction.go,
            onSubmitted: (value) async {
              var res = await attemptPostAnswer(card, value, widget.jwt);
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                        title: Text(jsonDecode(res!)["data"]["message"],
                            style: GoogleFonts.nunito(
                                fontSize: 22, fontWeight: FontWeight.w800)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
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
                                          MainPage.fromBase64(widget.jwt)));
                            },
                          )
                        ],
                      ));
            },
            maxLines: 1,
            decoration: const InputDecoration(
                filled: true,
                hintStyle: TextStyle(color: Colors.blueGrey),
                hintText: "Enter the answer"),
            style: GoogleFonts.lexendExa(),
          ),
          Text(utf8.decode(card.format.runes.toList())),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      QuestionWidget(widget.card!),
      const Padding(padding: EdgeInsets.all(20.0)),
      showWidget(widget.card!, context),
    ]);
  }
}
