import 'package:flutter/material.dart';

class Responsive {
  static double height(BuildContext context, double fraction) {
    return MediaQuery.of(context).size.height * fraction;
  }

  static double width(BuildContext context, double fraction) {
    return MediaQuery.of(context).size.width * fraction;
  }

  static double fontSize(BuildContext context, double fraction) {
    return MediaQuery.of(context).size.width * fraction;
  }

  static EdgeInsets padding(BuildContext context, double fraction) {
    double padding = MediaQuery.of(context).size.width * fraction;
    return EdgeInsets.all(padding);
  }

  static EdgeInsets symmetricPadding(BuildContext context, double verticalFraction, double horizontalFraction) {
    double verticalPadding = MediaQuery.of(context).size.height * verticalFraction;
    double horizontalPadding = MediaQuery.of(context).size.width * horizontalFraction;
    return EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding);
  }
}
