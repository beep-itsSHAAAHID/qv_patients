import 'package:flutter/material.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/helper/responsive.dart';

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
              style: TextStyle(
                  fontSize: Responsive.width(context, 0.05),
                  color: TColors.black.withOpacity(0.5)),
            ),
            Text(
              secondText,
              style: TextStyle(
                  fontSize: Responsive.width(context, 0.05),
                  fontWeight: FontWeight.bold,
                  color: TColors.black.withOpacity(0.5)),
            ),
          ],
        ));
  }
}
