import 'package:flutter/material.dart';
import 'package:mobile_app/custom_widgets/custom_drawer_list_tile.dart';
import 'package:mobile_app/screens/history_screen.dart';
import 'package:mobile_app/screens/info_screen.dart';

import '../screens/about_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.pink.shade50,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset("assets/ribbon.png",
                    width: MediaQuery.of(context).size.width / 5),
                const Text(
                  "Breast Cancer\nChecker",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            const Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomDrawerListTile(
                    onTap: () {
                      Navigator.pushNamed(context, HistoryScreen.id);
                    },
                    icon: Icons.history,
                    title: "Your History"),
                CustomDrawerListTile(
                    onTap: () {
                      Navigator.pushNamed(context, InfoScreen.id);
                    },
                    icon: Icons.health_and_safety_outlined,
                    title: "Prevention"),
                CustomDrawerListTile(
                    onTap: () {
                      Navigator.pushNamed(context, AboutScreen.id);
                    },
                    icon: Icons.message_outlined,
                    title: "About us"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
