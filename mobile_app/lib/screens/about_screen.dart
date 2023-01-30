import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  static const String id = "AboutScreenID";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        title: const Text("About the App"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffee9ca7), Color(0xffffdde1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.pink.shade50,
                  backgroundImage: const AssetImage("assets/ribbon.png"),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Breast Cancer\nChecker",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "Version 1.1.1",
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: const [
                  Text(
                    "\nThis interactive system for breast cancer checking and screening is developed by some engineering students as a participation in the breast cancer awareness campaign.\n\nPlease seek a doctor's advice in addition to using this app and before making any medical decisions",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text("\n\nCopyright © 2022 All Rights Reserved"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
