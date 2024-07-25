import 'package:flutter/material.dart';
import 'package:qv_patient/constants/colors.dart';

class BoxButton extends StatelessWidget {
  final String labelText;
  const BoxButton({
    super.key,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      child: Text(labelText,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .apply(color: TColors.white)),
      height: 100,
      decoration: BoxDecoration(
          color: TColors.primary, borderRadius: BorderRadius.circular(20)),
    );
  }
}
