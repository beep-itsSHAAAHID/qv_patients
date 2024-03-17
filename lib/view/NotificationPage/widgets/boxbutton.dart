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
      alignment: Alignment.center,
      child: Text(labelText,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .apply(color: TColors.dark)),
      width: 150,
      height: 100,
      decoration: BoxDecoration(
          color: TColors.light, borderRadius: BorderRadius.circular(20)),
    );
  }
}
