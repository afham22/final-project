// import 'package:flutter/cupertino.dart';
import 'package:bugetify_app/getStartedTwo.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_getx/content_page.dart';
// import 'package:get/get.dart';

class getStartedOPage extends StatefulWidget {
  const getStartedOPage({Key? key}) : super(key: key);

  @override
  _getStartedOPageState createState() => _getStartedOPageState();
}

class _getStartedOPageState extends State<getStartedOPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: const BackButton(
          color: Colors.pinkAccent,
        ),
      ),
      backgroundColor: Color(0xFF69c5df),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            height: 700,
            child: Container(
              height: 700,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/background.jpg"),
                      fit: BoxFit.cover)),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pick Your Favourite",
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Contests",
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 25,
                      child: Text(
                        "We make great design work "
                        "happen with our great community designer",
                        style: TextStyle(color: Colors.white60),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 200,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFffbc33e)),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Color(0xFFfbc33e),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => getStartedTPage()));
                      },
                      child: Text(
                        "Next",
                        style: TextStyle(color: Colors.white),
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
              ))
        ],
      ),
    );
  }
}
