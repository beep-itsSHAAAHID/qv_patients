import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/size.dart';
import 'package:qv_patient/controller/home_controller.dart';
import 'package:qv_patient/view/homepage/widgets/roundedcontiner.dart';
import 'package:qv_patient/view/homepage/widgets/t_rounded_image.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key,
    required this.banners,
  });
  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
          items: banners
              .map((url) => TRoundedImage(
                    padding: const EdgeInsets.all(16),
                    imageurl: url,
                  ))
              .toList(),
          options: CarouselOptions(
              viewportFraction: 1.5,
              onPageChanged: (index, _) =>
                  controller.UpdatePageIndicator(index)),
        ),
        const SizedBox(
          height: Tsizes.spcBtwitems,
        ),
        Center(
          child: Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < banners.length; i++)
                  TRoundContainer(
                    margin: const EdgeInsets.only(right: 10),
                    width: 20,
                    height: 4,
                    backgroundColor: controller.carousalCurrentIndex.value == i
                        ? TColors.light
                        : TColors.grey,
                  ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
