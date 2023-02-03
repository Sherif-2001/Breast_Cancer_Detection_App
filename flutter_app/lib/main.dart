import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/screens/about_screen.dart';
import 'package:flutter_app/screens/history_screen.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/screens/info_screen.dart';
import 'package:flutter_app/screens/splash_screen.dart';

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
