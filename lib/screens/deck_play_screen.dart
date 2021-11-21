import 'package:Memnix/models/deck.dart';
import 'package:Memnix/widgets/next_card_widget.dart';
import 'package:flutter/material.dart';

import '../bar.dart';

class DeckPlayScreen extends StatelessWidget {
  final String jwt;
  const DeckPlayScreen({Key? key, required this.jwt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: MyAppBar(jwt: jwt),
          body: NextCardWidget(jwt: jwt),
        ));
  }
}
