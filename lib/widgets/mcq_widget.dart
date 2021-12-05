import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memnix/models/memcard.dart';
import 'package:memnix/queries/post_answer.dart';

import 'answer_dialog.dart';

class McqButtonWidget extends StatefulWidget {
  final String answer;
  final MemCard card;
  final dynamic jwt;
  final bool today;

  const McqButtonWidget(this.answer, this.card, this.jwt, this.today, {Key? key})
      : super(key: key);

  @override
  _McqButtonWidget createState() => _McqButtonWidget();
}

class _McqButtonWidget extends State<McqButtonWidget> {
  get answer => widget.answer;
  get card => widget.card;
  get jwt => widget.jwt;
  get today => widget.today;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        String? res = await attemptPostAnswer(card, answer, jwt);
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return WillPopScope(
                  onWillPop: () async => false,
                  child: AnswerDialog(res: res, jwt: widget.jwt, today: today));
            });
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


