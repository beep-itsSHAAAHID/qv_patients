import 'package:flutter/material.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/helper/responsive.dart';

class SettingsMenuTile extends StatelessWidget {
  const SettingsMenuTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle,
      this.trailing,
      this.ontap});
  final IconData icon;
  final String title, subtitle;
  final Widget? trailing;
  final VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 28,
        color: TColors.primary,
      ),
      title: Text(
        title,
        style: TextStyle(
            color: TColors.black, fontSize: Responsive.width(context, 0.03)),
      ),
      subtitle: Text(subtitle,
          style: TextStyle(
              color: TColors.black, fontSize: Responsive.width(context, 0.02))),
      trailing: trailing,
      onTap: ontap,
    );
  }
}
