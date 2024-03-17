import 'package:flutter/material.dart';

class PageHeading extends StatelessWidget {
  const PageHeading({
    super.key,
    required this.headingText,
  });
  final String headingText;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Text(
          headingText,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Spacer(),
      ],
    );
  }
}
