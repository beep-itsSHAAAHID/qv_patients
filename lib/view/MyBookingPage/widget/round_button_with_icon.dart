import 'package:flutter/material.dart';
import 'package:qv_patient/constants/colors.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    super.key,
    this.onPfressed,
    required this.icon,
    this.coloricon,
  });
  final void Function()? onPfressed;
  final IconData icon;
  final Color? coloricon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(TColors.dark),
          padding: MaterialStatePropertyAll(EdgeInsets.all(14)),
          shape: MaterialStatePropertyAll(CircleBorder())),
      onPressed: onPfressed,
      child: Icon(
        icon,
        color: coloricon,
      ),
    );
  }
}
