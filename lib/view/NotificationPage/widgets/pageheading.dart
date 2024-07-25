import 'package:flutter/material.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/helper/responsive.dart';

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
        Text(headingText,
            style: TextStyle(
                color: TColors.black,
                fontWeight: FontWeight.bold,
                fontSize: Responsive.fontSize(context, 0.05))),
        Spacer(),
      ],
    );
  }
}
