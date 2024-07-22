import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qv_patient/constants/colors.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;

  const CustomSearchBar({
    super.key,
    this.hintText = 'Search...',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: TColors.grey, width: 1), // Border color and width
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Iconsax.search_normal, color: TColors.dark), // Search icon color
          ),
          Expanded(
            child: TextField(
              style: TextStyle(color: TColors.dark), // Text color
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: TColors.grey), // Hint text color
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15), // Padding
              ),
            ),
          ),
        ],
      ),
    );
  }
}
