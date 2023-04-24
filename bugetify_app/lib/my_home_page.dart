// import 'package:flutter/cupertino.dart';
import 'dart:async';

import 'package:bugetify_app/getStartedOne.dart';
import 'package:bugetify_app/screens/Login/login_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_getx/content_page.dart';
// import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> myArray = [
    'مرحبًا',
    'Hello',
    'こんにちは',
    'Bonjour',
    'नमस्ते',
    'Hola'
  ];
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Colors.lightBlue, Colors.yellow],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 90.0, 100.0));
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      changeText();
    });
  }

  void changeText() {
    setState(() {
      currentIndex = (currentIndex + 1) % myArray.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            height: 900,
            child: Container(
              height: 700,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/background1.jpg"),
                      fit: BoxFit.cover)),
            ),
          ),
          Positioned(
              bottom: 120,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    myArray[currentIndex] + ',',
                    style: TextStyle(
                        fontSize: 42,
                        foreground: Paint()..shader = linearGradient,
                        fontWeight: FontWeight.w700),
                  ),
                  const Text(
                    "Welcome to Budgetify",
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 25,
                      child: const Text(
                        "managing your finances is easy  \n"
                        "and stress-free!",
                        style:
                            TextStyle(color: Colors.pinkAccent, fontSize: 20),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 200,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                      },
                      child: const Text(
                        "Have an account?",
                        style:
                            TextStyle(color: Colors.pinkAccent, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const getStartedOPage()));
        },
        child: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.pinkAccent,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
