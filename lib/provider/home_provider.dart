import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeNotifier extends StateNotifier<int> {
  HomeNotifier() : super(0);

  void updatePageIndicator(int index) {
    state = index;
  }
}

final homeProvider = StateNotifierProvider<HomeNotifier, int>((ref) {
  return HomeNotifier();
});
