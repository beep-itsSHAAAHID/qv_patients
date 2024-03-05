import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qv_patient/view/homepage/home.dart';

class NavigationMenuController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screen = [const Home(), const Placeholder(), const Placeholder(), const Placeholder()];
}
