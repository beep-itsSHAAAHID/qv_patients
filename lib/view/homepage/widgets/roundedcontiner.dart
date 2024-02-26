import 'package:flutter/material.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/size.dart';

class TRoundContainer extends StatelessWidget {
  const TRoundContainer({
    super.key,
    this.height,
    this.width,
    this.backgroundColor = TColors.white,
    this.padding,
    this.radius = Tsizes.cardradiuslg,
    this.child,
    this.margin,
    this.showBorder = false,
    this.bordercolor = TColors.borderPrimary,
  });

  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final Color? backgroundColor;
  final Color bordercolor;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        border: showBorder ? Border.all(color: bordercolor) : null,
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
