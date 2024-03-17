import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/size.dart';
import 'package:qv_patient/view/homepage/widgets/sectionheading.dart';
import 'package:qv_patient/view/homepage/widgets/t_primary_continer.dart';
import 'package:qv_patient/view/settingsPage/widgets/custom_appbar.dart';
import 'package:qv_patient/view/settingsPage/widgets/settings_menu_tile.dart';
import 'package:qv_patient/view/settingsPage/widgets/t_user_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FadeInSlide(
          duration: 0.9,
          direction: FadeSlideDirection.ltr,
          child: Column(
            children: [
              //header
              TPrimaryHeaderContainer(
                child: Column(
                  children: [
                    TAppBar(
                      title: Text(
                        'Account',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .apply(color: TColors.white),
                      ),
                    ),
                    const SizedBox(
                      height: Tsizes.spcBtwitems - 5,
                    ),
                    //user profile card
                    const TUserProfileTile(),
                    const SizedBox(
                      height: Tsizes.spcbtwsections,
                    ),
                  ],
                ),
              ),
              //body
              Padding(
                padding: const EdgeInsets.all(Tsizes.defaultspace),
                child: Column(
                  children: [
                    const TSectionHeading(
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
                    //app Settings
                    const SizedBox(
                      height: Tsizes.spcbtwsections,
                    ),
                    const TSectionHeading(
                      title: 'App Settings',
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
                        value: true,
                        onChanged: (value) {},
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
                        onPressed: () {},
                        child: const Text("Log Out"),
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
