import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/helper/doc_helper_function.dart';
import 'package:qv_patient/provider/navigation_menu_provider.dart';
import 'package:qv_patient/view/homepage/AiDoctor/ai_doctor.dart';

class NavigationMenu extends ConsumerWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationMenuProvider);
    final navigationNotifier = ref.read(navigationMenuProvider.notifier);
    final darkMode = DocHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => navigationNotifier.updateIndex(index),
        backgroundColor: TColors.light,
        selectedItemColor: TColors.primary,
        unselectedItemColor: TColors.black,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.ticket),
            label: 'My Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.notification),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.user),
            label: 'Profile',
          ),
        ],
      ),
      body: navigationNotifier.screens[selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(CupertinoPageRoute(builder: (ctx) {
            return ChatBot();
          }));
        },
        child: CircleAvatar(
          backgroundColor: TColors.primary,
          radius: 30,
          backgroundImage: AssetImage('assets/image/chatbot.png'),
        ),
        backgroundColor:
            TColors.primary, // No background color for transparent look
        elevation: 2,
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
