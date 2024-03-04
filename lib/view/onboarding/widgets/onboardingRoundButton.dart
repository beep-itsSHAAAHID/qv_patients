import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/size.dart';
import 'package:qv_patient/controller/on_boarding_page_controller.dart';
import 'package:qv_patient/device/device_utility.dart';
import 'package:qv_patient/helper/doc_helper_function.dart';

class OnBoardingRoundButton extends StatelessWidget {
  const OnBoardingRoundButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = DocHelperFunctions.isDarkMode(context);
    return Positioned(
        bottom: TDeviceUtils.getBottomNavigationBarHeight(),
        right: Tsizes.defaultspace,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: dark ? TColors.primary : TColors.dark,
                shape: const CircleBorder()),
            onPressed: () {
              OnBoardingController.instance.nextPage();
            },
            child: const Icon(Iconsax.arrow_right_3)));
  }
}
