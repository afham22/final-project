// import 'package:flutter/cupertino.dart';
import 'package:bugetify_app/screens/emailCheck/emailCheck_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_getx/content_page.dart';
// import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class getStartedTPage extends StatefulWidget {
  const getStartedTPage({Key? key}) : super(key: key);

  @override
  _getStartedTPageState createState() => _getStartedTPageState();
}

class _getStartedTPageState extends State<getStartedTPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF69c5df),
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
          Positioned(
              top: 510,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign Up Now to Enjoy \nFinancial Freedom",
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
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
                            builder: (context) => emailCheckScreen()));
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(color: Colors.pinkAccent),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              )),
          Positioned(
            top: 180,
            right: 60,
            child: SizedBox(
              width: 280,
              height: 280,
              child: SvgPicture.asset(
                "assets/img/signup.svg",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
