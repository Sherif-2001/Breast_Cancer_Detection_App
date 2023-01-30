import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.pink.shade100,
      splash: Column(
        children: [
          Image.asset("assets/ribbon.png", scale: 3),
          const SizedBox(height: 20),
          const Text(
            "Breast Cancer Checker",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink),
          )
        ],
      ),
      nextScreen: const HomeScreen(),
      duration: 5000,
      animationDuration: const Duration(seconds: 1),
      centered: true,
      splashIconSize: 300,
    );
  }
}
