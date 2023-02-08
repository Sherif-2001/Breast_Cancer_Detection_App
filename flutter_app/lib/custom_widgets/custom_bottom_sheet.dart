import 'package:flutter/material.dart';
import 'package:flutter_app/custom_widgets/bottom_sheet_item.dart';

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
              BottomSheetItem(
                onPressed: onCameraTap,
                label: "Camera",
                icon: Icons.camera_alt,
              ),
              BottomSheetItem(
                onPressed: onGalleryTap,
                label: "Gallery",
                icon: Icons.image_rounded,
              )
            ],
          ),
        ],
      ),
    );
  }
}
