import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tumor_ai_model/screens/about_screen.dart';
import 'package:tumor_ai_model/screens/history_screen.dart';
import 'package:tumor_ai_model/screens/home_screen.dart';
import 'package:tumor_ai_model/screens/info_screen.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        AboutScreen.id: (context) => const AboutScreen(),
        InfoScreen.id: (context) => const InfoScreen(),
        HistoryScreen.id: (context) => const HistoryScreen()
      },
      theme: ThemeData(fontFamily: "CodeNewRoman"),
    );
  }
}

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
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.pink,
            ),
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
