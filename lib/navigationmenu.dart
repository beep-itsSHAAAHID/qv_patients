import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/controller/navigationcontroller.dart';
import 'package:qv_patient/helper/doc_helper_function.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationMenuController());
    final darkMode = DocHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
            height: 80,
            selectedIndex: controller.selectedIndex.value,
            elevation: 1,
            backgroundColor: darkMode ? TColors.dark : TColors.light,
            indicatorColor: darkMode
                ? TColors.white.withOpacity(0.1)
                : TColors.black.withOpacity(0.1),
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            destinations: const [
              NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
              NavigationDestination(
                  icon: Icon(Iconsax.ticket), label: 'My Bookings'),
              NavigationDestination(
                  icon: Icon(Iconsax.notification), label: 'Notifications'),
              NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
            ]),
      ),
      body: Obx(() => controller.screen[controller.selectedIndex.value]),
    );
  }
}
