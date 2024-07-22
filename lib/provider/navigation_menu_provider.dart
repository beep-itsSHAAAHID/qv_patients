import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qv_patient/view/MyBookingPage/mybookingpage.dart';
import 'package:qv_patient/view/NotificationPage/notification_screen.dart';
import 'package:qv_patient/view/homepage/home.dart';
import 'package:qv_patient/view/settingsPage/settings.dart';

class NavigationMenuNotifier extends StateNotifier<int> {
  NavigationMenuNotifier() : super(0);

  void updateIndex(int index) {
    state = index;
  }

  List<Widget> get screens => [
    const Home(),
    const MyBookingPage(),
    const NotificationPage(),
    const SettingsScreen()
  ];
}

final navigationMenuProvider = StateNotifierProvider<NavigationMenuNotifier, int>((ref) {
  return NavigationMenuNotifier();
});
