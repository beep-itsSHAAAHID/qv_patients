import 'package:flutter/material.dart';
import 'package:qv_patient/constants/size.dart';
import 'package:qv_patient/controller/on_boarding_page_controller.dart';
import 'package:qv_patient/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: Tsizes.defaultspace,
      child: TextButton(
        onPressed: () => OnBoardingController.instance.skipPage(),
        child: const Text("Skip"),
      ),
    );
  }
}
