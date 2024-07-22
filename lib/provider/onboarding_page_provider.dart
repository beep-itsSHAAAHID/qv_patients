import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qv_patient/view/Authentication/get_started_view.dart';

class OnBoardingNotifier extends StateNotifier<int> {
  OnBoardingNotifier() : super(0);

  final PageController pageController = PageController();

  void updatePageIndicator(int index) {
    state = index;
  }

  void dotNavigationClick(int index) {
    state = index;
    pageController.jumpToPage(index);
  }

  void nextPage(BuildContext context) {
    if (state == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const GetStartedView()),
      );
    } else {
      int page = state + 1;
      pageController.jumpToPage(page);
      state = page;
    }
  }

  void skipPage() {
    state = 2;
    pageController.jumpToPage(2);
  }
}

final onBoardingProvider = StateNotifierProvider<OnBoardingNotifier, int>((ref) {
  return OnBoardingNotifier();
});
