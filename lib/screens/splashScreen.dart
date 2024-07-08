import 'package:flutter/material.dart';
import 'package:fjeje_timbu/constants/OnboardData.dart';
import 'package:fjeje_timbu/screens/onboardingScreen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class Splash2 extends StatelessWidget {
  const Splash2({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splash: 'assets/p1.png', // Adjust the path if needed
      nextScreen:  OnBoarding(
        images: imageList,
        titles: titlesList,
        subtitles: subtitlesList,
      ),
      splashTransition: SplashTransition.scaleTransition,
      backgroundColor: Colors.black,
    );
  }
}
