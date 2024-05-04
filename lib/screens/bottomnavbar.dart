import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dealdiscover/screens/accueil_screen.dart';
import 'package:dealdiscover/screens/bot_screen.dart';
import 'package:dealdiscover/screens/calendar_screen.dart';
import 'package:dealdiscover/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dealdiscover/utils/colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List Screens = [
    AccueilScreen(),
    BotScreen(),
    CalendarScreen(),
    ProfileScreen(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: MyColors.btnColor,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          Image(
            image: AssetImage('assets/images/home.png'),
            width: 30,
            height: 30,
          ),
          Image(
            image: AssetImage('assets/images/botw.png'),
            width: 35,
            height: 35,
          ),
          Image(
            image: AssetImage('assets/images/calendar.png'),
            width: 30,
            height: 30,
          ),
          Image(
            image: AssetImage('assets/images/user.png'),
            width: 30,
            height: 30,
          ),
        ],
      ),
      body: Screens[_selectedIndex],
    );
  }
}
