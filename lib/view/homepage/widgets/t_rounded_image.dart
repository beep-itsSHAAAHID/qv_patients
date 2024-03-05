import 'package:flutter/material.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/size.dart';

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageurl,
    this.applyImageRadius = true,
    this.border,
    this.backGroundcolor = TColors.light,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkImg = false,
    this.onPressed,
    this.borderRadius = Tsizes.md,
  });

  final double? width, height;
  final String imageurl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backGroundcolor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImg;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
            borderRadius: applyImageRadius
                ? BorderRadius.circular(borderRadius)
                : BorderRadius.zero,
            child: Image(
              image: isNetworkImg
                  ? NetworkImage(imageurl)
                  : AssetImage(imageurl) as ImageProvider,
              fit: fit,
            )),
      ),
    );
  }
}
