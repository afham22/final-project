import 'package:bugetify_app/screens/Login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AppHome extends StatefulWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  _MyAppHomeState createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<AppHome> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Scaffold(
      body: SingleChildScrollView(
        child: MobileLoginScreen(),
      ),
    ),
    Text(
      'Likes',
      style: optionStyle,
    ),
    Text(
      'Search',
      style: optionStyle,
    )
  ];

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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: GNav(
              backgroundColor: Colors.white,
              color: Colors.pink,
              activeColor: Colors.pink.shade700,
              tabBackgroundColor: Colors.pinkAccent.shade100,
              padding: EdgeInsets.all(16),
              gap: 8,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'home',
                ),
                GButton(
                  icon: Icons.favorite,
                  text: 'likes',
                ),
                GButton(
                  icon: Icons.search,
                  text: 'search',
                )
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              }),
        ),
      ),
    );
  }
}
