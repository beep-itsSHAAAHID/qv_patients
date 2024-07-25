import 'package:flutter/material.dart';

class MyButtonWithText extends StatelessWidget {
  const MyButtonWithText({
    super.key,
    required this.text,
    this.textColor,
    this.backgroundColor,
  });
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: ElevatedButton(
          style: ButtonStyle(
              side: WidgetStatePropertyAll(BorderSide.none),
              padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 40)),
              backgroundColor: MaterialStatePropertyAll(backgroundColor)),
          onPressed: () {},
          child: Text(
            text,
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          )),
    );
  }
}
