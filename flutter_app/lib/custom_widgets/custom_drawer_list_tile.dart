import 'package:flutter/material.dart';

class CustomDrawerListTile extends StatelessWidget {
  const CustomDrawerListTile(
      {super.key, required this.icon, required this.title,required this.onTap});
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: Colors.pink,
        size: 30,
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
