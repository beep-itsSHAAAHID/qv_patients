import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:qv_patient/constants/image_url.dart';
import 'package:qv_patient/constants/size.dart';
import 'package:qv_patient/constants/text_string.dart';
import 'package:qv_patient/controller/on_boarding_page_controller.dart';
import 'package:qv_patient/device/device_utility.dart';
import 'package:qv_patient/view/onboarding/widgets/on_boarding_page.dart';
import 'package:qv_patient/view/onboarding/widgets/onboardingNavigation.dart';
import 'package:qv_patient/view/onboarding/widgets/onboardingRoundButton.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                imgurl: TImages.onBoardingImage1,
                title: TTexts.onBoardingTitle1,
                subtitle: TTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                imgurl: TImages.onBoardingImage2,
                title: TTexts.onBoardingTitle2,
                subtitle: TTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                imgurl: TImages.onBoardingImage3,
                title: TTexts.onBoardingTitle3,
                subtitle: TTexts.onBoardingSubTitle3,
              )
            ],
          ),
          const OnBoardingSkip(),
          const OnboardingNavigation(),
          const OnBoardingRoundButton()
        ],
      ),
    );
  }
}

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: Tsizes.defaultspace,
      child: TextButton(
        onPressed: () {
          controller.skipPage();
        },
        child: const Text("Skip"),
      ),
    );
  }
}
