import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/welcome_screen.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'bar.dart';
import 'mcq_widget.dart';
import 'question_widget.dart';

const storage = FlutterSecureStorage();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "jwt");
    if (jwt == null) return "";
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Memnix',
      home: FutureBuilder(
          future: jwtOrEmpty,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            return const DoubleBack(
              message: "Press back again to close",
              child: WelcomeScreen(),
            );
          }),
    );
  }
}

class MemCard {
  final String question;
  final String imageUrl;
  final int id;
  late String response0;
  late String response1;
  late String response2;
  late String response3;
  final int type;
  final String format;

  MemCard(
    this.response0,
    this.response1,
    this.response2,
    this.response3, {
    required this.question,
    required this.type,
    required this.id,
    required this.imageUrl,
    required this.format,
  });

  factory MemCard.fromJson(Map<String, dynamic> json) {
    var card = MemCard(
      '',
      '',
      '',
      '',
      type: json["Card"]["card_type"],
      id: json["Card"]["ID"],
      imageUrl: json["Card"]["card_image"],
      question: json["Card"]["card_question"],
      format: json["Card"]["card_format"],
    );
    if (json["Card"]["card_type"] == 2) {
      card.response0 = json["Answers"][0];
      card.response1 = json["Answers"][1];
      card.response2 = json["Answers"][2];
      card.response3 = json["Answers"][3];
    } else {
      card.response0 = json["Card"]["card_answer"];
    }

    return card;
  }
}

Future<MemCard> attemptTodayCard(dynamic jwt) async {
  var res = await http.get(
    Uri.parse('http://192.168.1.151:1813/api/v1/cards/today'),
    headers: {"Cookie": jwt},
  );
  if (res.statusCode == 200) {
    return MemCard.fromJson(jsonDecode(res.body)["data"]);
  } else {
    throw Exception('Failed to load card');
  }
}

Future<String?> attemptPostAnswer(
    MemCard card, String answer, dynamic jwt) async {
  var res = await http.post(
      Uri.parse('http://192.168.1.151:1813/api/v1/cards/response'),
      headers: {"Content-Type": "application/json", "Cookie": jwt},
      body: json.encode({'card_id': card.id, 'response': answer}));
  if (res.statusCode == 200) {
    return res.body;
  }
  return null;
}

class CardWidget extends StatefulWidget {
  const CardWidget({Key? key, required this.jwt}) : super(key: key);
  final String jwt;

  @override
  _CardWidget createState() => _CardWidget();
}

class _CardWidget extends State<CardWidget> {
  get jwt => widget.jwt;
  late Future<MemCard> futureCard;

  @override
  Widget build(BuildContext context) {
    futureCard = attemptTodayCard(jwt);
    return Scaffold(
        appBar: const CardAppBar(),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder<MemCard>(
                future: futureCard,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return TodaysWidget(
                      card: snapshot.data,
                      jwt: jwt,
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                })));
  }
}

class TodaysWidget extends StatelessWidget {
  final MemCard? card;
  final dynamic jwt;

  TodaysWidget({Key? key, required this.card, required this.jwt})
      : super(key: key);

  final TextEditingController textController = TextEditingController();

  showWidget(MemCard card, dynamic context) {
    if (card.type == 2) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            McqButtonWidget(card.response0, card, jwt),
            const Padding(padding: EdgeInsets.all(10.0)),
            McqButtonWidget(card.response1, card, jwt),
            const Padding(padding: EdgeInsets.all(10.0)),
            McqButtonWidget(card.response2, card, jwt),
            const Padding(padding: EdgeInsets.all(10.0)),
            McqButtonWidget(card.response3, card, jwt),
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
              var res = await attemptPostAnswer(card, value, jwt);
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
                                          MainPage.fromBase64(jwt)));
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
      QuestionWidget(card!),
      const Padding(padding: EdgeInsets.all(20.0)),
      showWidget(card!, context),
    ]);
  }
}

class MainPage extends StatefulWidget {
  final String jwt;
  final Map<String, dynamic> payload;

  const MainPage({Key? key, required this.jwt, required this.payload})
      : super(key: key);

  @override
  _MainPage createState() => _MainPage();

  static fromBase64(String jwt) => MainPage(
      jwt: jwt,
      payload: json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));
}

class _MainPage extends State<MainPage> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  get jwt => widget.jwt;

  @override
  Widget build(BuildContext context) {
    final List _children = [
      //const CardsPage(),
      const PlaceholderWidget(Colors.red),
      CardWidget(jwt: jwt),
      const PlaceholderWidget(Colors.green)
    ];
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          //appBar: const MyAppBar(),
          bottomNavigationBar: BottomNavigationBar(
            selectedFontSize: 14,
            selectedIconTheme: const IconThemeData(size: 26),
            unselectedLabelStyle: GoogleFonts.nunito(),
            selectedLabelStyle: GoogleFonts.nunito(fontWeight: FontWeight.bold),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.view_list),
                label: "Cards",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
          body: _children[_selectedIndex],
        ));
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
