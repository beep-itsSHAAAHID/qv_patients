import 'package:flutter/material.dart';

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
      style: ButtonStyle(
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
