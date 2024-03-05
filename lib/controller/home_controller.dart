import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  Rx<int> carousalCurrentIndex = 0.obs;

  void UpdatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }
}
