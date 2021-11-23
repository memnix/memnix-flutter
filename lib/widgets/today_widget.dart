import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Memnix/models/memcard.dart';
import 'package:Memnix/queries/postAnswer.dart';
import 'package:Memnix/widgets/answer_dialog.dart';
import 'package:Memnix/widgets/mcq_widget.dart';
import 'package:Memnix/widgets/question_widget.dart';

class TodaysWidget extends StatefulWidget {
  final MemCard? card;
  final dynamic jwt;
  final bool today;

  const TodaysWidget({Key? key, required this.card, required this.jwt, required this.today})
      : super(key: key);

  @override
  State<TodaysWidget> createState() => _TodaysWidgetState();
}

class _TodaysWidgetState extends State<TodaysWidget> {
  final TextEditingController textController = TextEditingController();

  get today => widget.today;
  TextInputType keyType = TextInputType.text;

  showWidget(MemCard card, dynamic context) {
    if (card.type == 2) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            McqButtonWidget(card.response0, card, widget.jwt, today),
            const Padding(padding: EdgeInsets.all(8.0)),
            McqButtonWidget(card.response1, card, widget.jwt, today),
            const Padding(padding: EdgeInsets.all(8.0)),
            McqButtonWidget(card.response2, card, widget.jwt, today),
            const Padding(padding: EdgeInsets.all(8.0)),
            McqButtonWidget(card.response3, card, widget.jwt, today),
          ]);
    } else {
      if (card.type == 1) {
        keyType = TextInputType.number;
      } else if (card.type == 0) {
        keyType = TextInputType.text;
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Padding(padding: EdgeInsets.all(15.0)),
          TextField(
            controller: textController,
            keyboardType: keyType,
            textInputAction: TextInputAction.go,
            onSubmitted: (value) async {
              var res = await attemptPostAnswer(card, value, widget.jwt);
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return WillPopScope(
                        onWillPop: () async => false,
                        child: AnswerDialog(res: res, jwt: widget.jwt, today: today));
                  });
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
      const Padding(padding: EdgeInsets.all(10.0)),
      showWidget(widget.card!, context),
    ]);
  }
}
