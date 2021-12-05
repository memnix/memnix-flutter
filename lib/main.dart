import 'package:memnix/screens/main_screen.dart';
import 'package:memnix/screens/welcome_screen.dart';
import 'package:memnix/services/storage.dart';
import 'package:flutter/material.dart';

import 'package:double_back_to_close/double_back_to_close.dart';

import 'models/deck.dart';

final SecureStorage secureStorage = SecureStorage();
Deck currentDeck = Deck(0, "", "", "", 0);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Memnix',
      home: FutureBuilder(
          future: secureStorage.jwtOrEmpty,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            if (snapshot.data != "") return MainPage.fromBase64(snapshot.data.toString());
            return const DoubleBack(
                message: "Press back again to close",
                child: WelcomeScreen(),
              );
            }
          ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  const PlaceholderWidget(this.color, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
