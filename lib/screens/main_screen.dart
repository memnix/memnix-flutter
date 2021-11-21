import 'dart:convert';

import 'package:Memnix/screens/decks_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Memnix/widgets/card_widget.dart';
import 'package:Memnix/widgets/profile_widget.dart';

class MainPage extends StatefulWidget {
  final String jwt;
  final Map<String, dynamic> payload;

  const MainPage({Key? key, required this.jwt, required this.payload})
      : super(key: key);

  @override
  _MainPage createState() => _MainPage();

  //TODO: function to go back to decks list

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
      DecksPage(jwt: jwt),
      CardWidget(jwt: jwt),
      ProfileWidget(jwt: jwt),
    ];
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            selectedFontSize: 14,
            selectedIconTheme: const IconThemeData(size: 26),
            unselectedLabelStyle: GoogleFonts.nunito(),
            selectedLabelStyle: GoogleFonts.nunito(fontWeight: FontWeight.bold),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.view_list),
                label: "Decks",
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
