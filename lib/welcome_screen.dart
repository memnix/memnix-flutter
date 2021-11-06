import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/main.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WelcomeBody(),
    );
  }
}

class WelcomeBody extends StatefulWidget {
  const WelcomeBody({Key? key}) : super(key: key);

  @override
  _WelcomeBody createState() => _WelcomeBody();
}

class _WelcomeBody extends State<WelcomeBody> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        ShaderMask(
            shaderCallback: (rect) => const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [Colors.black, Colors.transparent],
                ).createShader(rect),
            blendMode: BlendMode.darken,
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/back1.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              )),
            )),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(children: [
              Flexible(
                child: Center(
                  child: Text("Memnix",
                      style: GoogleFonts.architectsDaughter(
                          color: Colors.white,
                          fontSize: 60,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  height: size.height * 0.08,
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.grey[500]?.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          prefixIcon: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(FontAwesomeIcons.envelope,
                                size: 30, color: Colors.white),
                          ),
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: GoogleFonts.lexendDeca(
                              color: Colors.white, fontSize: 25, height: 1.5)),
                      style: const TextStyle(
                          fontSize: 22, color: Colors.white, height: 1.5),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  height: size.height * 0.08,
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.grey[500]?.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          prefixIcon: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(FontAwesomeIcons.lock,
                                size: 30, color: Colors.white),
                          ),
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: GoogleFonts.lexendDeca(
                              color: Colors.white, fontSize: 25, height: 1.5)),
                      obscureText: true,
                      style: const TextStyle(
                          fontSize: 22, color: Colors.white, height: 1.5),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                  height: size.height * 0.08,
                  width: size.width * 0.8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.red,
                      onSurface: Colors.red,
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () async {
                      var jwt = await attemptLogIn(
                          _usernameController.text, _passwordController.text);
                      if (jwt != null) {
                        storage.write(key: "jwt", value: jwt);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MainPage.fromBase64(jwt)));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                                title: Text("An Error Occurred"),
                                content: Text(
                                    "No account was found matching that username and password")));
                      }
                    },
                    child: Text(
                      "Login",
                      style: GoogleFonts.lexendDeca(
                          color: Colors.white, fontSize: 30, height: 1.5),
                    ),
                  ))
            ])),
      ],
    );
  }

  Future<String?> attemptLogIn(String email, String password) async {
    var res = await http.post(Uri.parse('http://192.168.1.151:1813/api/login'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({'email': email, 'password': password}));
    if (res.statusCode == 200) {
      var cookie = res.headers['set-cookie'];
      return cookie;
    }
    return null;
  }
}
