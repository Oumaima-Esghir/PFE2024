import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'onboarding _screen .dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/background.png'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
        ),
        AnimatedSplashScreen(
          splash: Image.asset(
            'assets/images/logo.png',
            width: MediaQuery.of(context).size.width * 2, // Adjust the width as needed
            height: MediaQuery.of(context).size.height * 2, // Adjust the height as needed
            fit: BoxFit.contain,
          ),
          duration: 3000,
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.transparent,
          nextScreen: OnboardingScreen(),
        ),
      ],
    );
  }
}
