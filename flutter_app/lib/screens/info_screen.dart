import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});
  static const String id = "InfoScreenID";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prevention"),
        backgroundColor: Colors.pink[400],
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
        child: const Center(
          child: Text(
            "Many factors over the course of a lifetime can influence the breast cancer risk such as getting older or the family history, but you can help lower the risk of breast cancer by taking care of your health in the following ways: \n\n\u2022 Maintain a healthy weight \n\u2022 Be physically Active \n\u2022 Breastfeed the children \n\u2022 Limit postmenopausal hormone therapy",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
