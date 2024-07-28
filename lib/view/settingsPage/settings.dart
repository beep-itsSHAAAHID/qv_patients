import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/size.dart';
import 'package:qv_patient/provider/settings_provider.dart';
import 'package:qv_patient/view/homepage/widgets/sectionheading.dart';
import 'package:qv_patient/view/homepage/widgets/t_primary_continer.dart';
import 'package:qv_patient/view/settingsPage/widgets/custom_appbar.dart';
import 'package:qv_patient/view/settingsPage/widgets/settings_menu_tile.dart';
import 'package:qv_patient/view/settingsPage/widgets/t_user_tile.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationEnabled = ref.watch(settingsProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 252, 252, 246),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TPrimaryHeaderContainer(
                child: Column(
                  children: [
                    TAppBar(
                      title: Text(
                        'Account',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .apply(color: TColors.dark),
                      ),
                    ),
                    const SizedBox(
                      height: Tsizes.spcBtwitems - 5,
                    ),
                    const TUserProfileTile(),
                    const SizedBox(
                      height: Tsizes.spcbtwsections,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Tsizes.defaultspace),
                child: Column(
                  children: [
                    const TSectionHeading(
                      textColor: TColors.black,
                      title: 'Account Settings',
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: Tsizes.spcBtwitems,
                    ),
                    SettingsMenuTile(
                      icon: Iconsax.heart,
                      title: 'Favourite',
                      subtitle: 'Your favourite doctor here',
                      ontap: () {},
                    ),
                    SettingsMenuTile(
                      icon: Iconsax.bank,
                      title: 'Bank Account',
                      subtitle: 'For transactions and payment',
                      ontap: () {},
                    ),
                    SettingsMenuTile(
                      icon: Iconsax.discount_shape,
                      title: 'My Coupons',
                      subtitle: 'List of all the discounted coupons',
                      ontap: () {},
                    ),
                    SettingsMenuTile(
                      icon: Iconsax.notification,
                      title: 'Notification',
                      subtitle: 'Set any kind of notification message',
                      ontap: () {},
                    ),
                    SettingsMenuTile(
                      icon: Iconsax.security_card,
                      title: 'Account privacy',
                      subtitle: 'manage data usage and connected Accounts',
                      ontap: () {},
                    ),
                    const SizedBox(
                      height: Tsizes.spcbtwsections,
                    ),
                    const TSectionHeading(
                      title: 'App Settings',
                      textColor: TColors.black,
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: Tsizes.spcBtwitems,
                    ),
                    SettingsMenuTile(
                      icon: Iconsax.location,
                      title: 'Set Location',
                      subtitle: "Set recommendation based on location ",
                      trailing: Switch(
                        value: locationEnabled,
                        onChanged: (value) {
                          ref
                              .read(settingsProvider.notifier)
                              .toggleLocation(value);
                        },
                      ),
                    ),
                    SettingsMenuTile(
                      icon: Iconsax.info_circle,
                      title: 'Help Center',
                      subtitle: 'Need Help Contact us!',
                      ontap: () {},
                    ),
                    const SizedBox(
                      height: Tsizes.spcbtwsections,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          ref.read(settingsProvider.notifier).signOut(context);
                        },
                        child: const Text(
                          "Log Out",
                          style: TextStyle(color: TColors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: Tsizes.spcbtwsections * 2,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
