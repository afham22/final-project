// import 'package:flutter/cupertino.dart';
import 'package:bugetify_app/getStartedTwo.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_getx/content_page.dart';
// import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class getStartedOPage extends StatefulWidget {
  const getStartedOPage({Key? key}) : super(key: key);

  @override
  _getStartedOPageState createState() => _getStartedOPageState();
}

class _getStartedOPageState extends State<getStartedOPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF69c5df),
      body: Stack(
        children: [
          // Background image positioned container
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
          // Back button positioned container
          Positioned(
            top: 40, // Adjust as needed
            left: 10, // Adjust as needed
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.pinkAccent,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          // Main content positioned container
          Positioned(
            top: 190,
            left: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Take control of your \n finances",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Track,",
                  style: TextStyle(
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.w700,
                      fontSize: 32),
                ),
                Text(
                  "Manage,",
                  style: TextStyle(
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.w700,
                      fontSize: 32),
                ),
                Text(
                  "and Visualize",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.w700,
                      fontSize: 32),
                ),
              ],
            ),
          ),
          // SVG image positioned container
          Positioned(
            bottom: 150,
            right: 60,
            child: SizedBox(
              width: 280,
              height: 280,
              child: SvgPicture.asset(
                "assets/img/financegirl.svg",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => getStartedTPage()));
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
