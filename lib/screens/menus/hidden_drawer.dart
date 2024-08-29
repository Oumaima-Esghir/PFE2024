import 'package:dealdiscover/screens/PartnerScreens/deals_management_screen.dart';
import 'package:dealdiscover/screens/PartnerScreens/profilepartner_screen.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];

  final myTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: Colors.black,
  );

  @override
  void initState() {
    super.initState();

    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'Profile',
            baseStyle: TextStyle(),
            selectedStyle: myTextStyle,
            colorLineSelected: MyColors.btnBorderColor),
        ProfileAsPartnerScreen(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'Deals Management',
            baseStyle: TextStyle(),
            selectedStyle: myTextStyle),
        DealsManagementScreen(),
      ),
    ];
  }

  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: MyColors.PColor,
      screens: _pages,
      initPositionSelected: 0,
      slidePercent: 60,
      contentCornerRadius: 30,
    );
  }
}
