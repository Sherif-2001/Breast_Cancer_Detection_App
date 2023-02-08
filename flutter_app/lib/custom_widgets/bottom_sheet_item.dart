import 'package:flutter/material.dart';

class BottomSheetItem extends StatelessWidget {
  const BottomSheetItem(
      {super.key,
      required this.onPressed,
      required this.label,
      required this.icon});

  final VoidCallback onPressed;
  final String label;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.pink,
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: Colors.pink.shade50,
              size: 30,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
