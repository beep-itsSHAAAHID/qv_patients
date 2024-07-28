import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qv_patient/view/MyBookingPage/mybookingpage.dart';
import 'package:qv_patient/view/NotificationPage/notification_screen.dart';
import 'package:qv_patient/view/homepage/home.dart';
import 'package:qv_patient/view/packageselectionpage/package_selection_page.dart';
import 'package:qv_patient/view/reportpage/report_page.dart';
import 'package:qv_patient/view/reportpage/report_page_view.dart';
import 'package:qv_patient/view/settingsPage/settings.dart';

class NavigationMenuNotifier extends StateNotifier<int> {
  NavigationMenuNotifier() : super(0);

  void updateIndex(int index) {
    state = index;
  }

  List<Widget> get screens => [
        const Home(),
        const MyBookingPage(),
        ReportPageView(),
        const SettingsScreen()
      ];
}

final navigationMenuProvider =
    StateNotifierProvider<NavigationMenuNotifier, int>((ref) {
  return NavigationMenuNotifier();
});
