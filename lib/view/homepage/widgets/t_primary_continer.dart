import 'package:flutter/material.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/helper/doc_helper_function.dart';
import 'package:qv_patient/view/homepage/widgets/double_container_with_curve_btw.dart';
import 'package:qv_patient/view/homepage/widgets/roundedcontiner.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final dark = DocHelperFunctions.isDarkMode(context);
    return TCurvedEdgesWidgets(
      child: Container(
        color: dark ? TColors.light : TColors.dark,
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -250,
                child: TRoundContainer(
                  width: 400,
                  height: 400,
                  radius: 400,
                  backgroundColor: dark
                      ? TColors.dark.withOpacity(0.1)
                      : TColors.light.withOpacity(0.1),
                ),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: TRoundContainer(
                  width: 400,
                  height: 400,
                  radius: 400,
                  backgroundColor: dark
                      ? TColors.dark.withOpacity(0.1)
                      : TColors.light.withOpacity(0.1),
                ),
              ),
              child
            ],
          ),
        ),
      ),
    );
  }
}
