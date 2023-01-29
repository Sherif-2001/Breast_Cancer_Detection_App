import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet(
      {super.key, required this.onGalleryTap, required this.onCameraTap});

  final VoidCallback onGalleryTap;
  final VoidCallback onCameraTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.pink,
                    child: IconButton(
                      onPressed: onGalleryTap,
                      icon: Icon(
                        Icons.image,
                        color: Colors.pink.shade50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text("Gallery")
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.pink,
                    child: IconButton(
                      onPressed: onCameraTap,
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.pink.shade50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text("Camera")
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
