import 'package:flutter/material.dart';

class RowWith2Text extends StatelessWidget {
  const RowWith2Text({
    super.key,
    required this.firsttext,
    required this.secondText,
  });
  final String firsttext, secondText;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              firsttext,
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            Text(
              secondText,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}
