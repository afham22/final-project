import 'package:bugetify_app/dashboard.dart';
import 'package:bugetify_app/feature.dart';
import 'package:bugetify_app/screens/Login/login_screen.dart';
import 'package:bugetify_app/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AppHome extends StatefulWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  _MyAppHomeState createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<AppHome> {
  int _selectedIndex = 1;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static List<Widget> _widgetOptions = <Widget>[
    CalendarHomePage(), // updated
    Dashboard(),
    Feature()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              tabs: [
                GButton(
                  icon: Icons.calendar_month,
                  text: 'Calendar',
                ),
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.bar_chart,
                  text: 'Statistics',
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
