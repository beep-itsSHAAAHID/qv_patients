import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qv_patient/view/MyBookingPage/mybookingpage.dart';
import 'package:qv_patient/view/NotificationPage/notification_screen.dart';
import 'package:qv_patient/view/homepage/home.dart';
import 'package:qv_patient/view/settingsPage/settings.dart';

class NavigationMenuController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screen = [
    const Home(),
    const MyBookingPage(),
    const NotificationPage(),
    const SettingsScreen()
  ];
}
