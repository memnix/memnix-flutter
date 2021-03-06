import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memnix/models/memcard.dart';

class QuestionWidget extends StatefulWidget {
  final MemCard card;
  const QuestionWidget(this.card, {Key? key}) : super(key: key);

  @override
  _QuestionWidget createState() => _QuestionWidget();
}

class QuestionDecoration extends StatelessWidget {
  final MemCard card;
  const QuestionDecoration(this.card, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (card.imageUrl.length <= 5) {
      return Container(
        decoration: const BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            )),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: const BorderRadius.all(
            Radius.circular(18),
          ),
          image: DecorationImage(
              opacity: 160,
              fit: BoxFit.cover,
              image: NetworkImage(card.imageUrl)),
        ),
      );
    }
  }
}

class _QuestionWidget extends State<QuestionWidget> {
  MemCard get card => widget.card;

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.all(10),
      height: 260,
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                    title: Text("Full Card",
                        style: GoogleFonts.nunito(
                            fontSize: 22, fontWeight: FontWeight.w900)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    children: [
                      Image(
                          image: NetworkImage(card.imageUrl),
                          fit: BoxFit.contain),
                      const Padding(padding: EdgeInsets.all(5.0)),
                      Text(utf8.decode(card.question.runes.toList()),
                          style: GoogleFonts.lexendDeca(
                              fontSize: 22, fontWeight: FontWeight.w800))
                    ],
                  ));
        },
        child: Stack(
          children: [
            QuestionDecoration(card),
            Center(
              child: Text(utf8.decode(card.question.runes.toList()),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                  style: GoogleFonts.lexendDeca(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
