import 'package:dealdiscover/screens/UserScreens/accueil_screen.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DealDiscover',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.transparentColor),
        useMaterial3: true,
      ),
      home: //AccueilScreen()
          SplashScreen(),
    );
  }
}
