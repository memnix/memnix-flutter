import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Memnix/models/memcard.dart';

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
        height: 170,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            )),
      );
    } else {
      return Container(
          height: 170,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(card.imageUrl))));
    }
  }
}

class _QuestionWidget extends State<QuestionWidget> {
  MemCard get card => widget.card;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        height: 250,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                spreadRadius: 4,
                blurRadius: 6,
                offset: const Offset(0, 3),
              )
            ]),
        child: GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                        title: Text("Full Card",
                            style: GoogleFonts.nunito(
                                fontSize: 22, fontWeight: FontWeight.w800)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        children: [
                          Image(
                              image: NetworkImage(card.imageUrl),
                              fit: BoxFit.contain),
                          const Padding(padding: EdgeInsets.all(5.0)),
                          Text(utf8.decode(card.question.runes.toList()),
                              style: GoogleFonts.lexendDeca(
                                  fontSize: 20, fontWeight: FontWeight.w500))
                        ],
                      ));
            },
            child: Column(children: [
              QuestionDecoration(card),
              const Padding(padding: EdgeInsets.all(5.0)),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(utf8.decode(card.question.runes.toList()),
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunito(
                              fontSize: 18, fontWeight: FontWeight.w800)),
                    ]),
              )
            ])));
  }
}
