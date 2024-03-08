import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/image_url.dart';
import 'package:qv_patient/constants/size.dart';
import 'package:qv_patient/helper/doc_helper_function.dart';
import 'package:qv_patient/model/searchbar.dart';
import 'package:qv_patient/view/BookingPage/bookingpage.dart';
import 'package:qv_patient/view/homepage/widgets/docCaed.dart';
import 'package:qv_patient/view/homepage/widgets/promo_slider.dart';
import 'package:qv_patient/view/homepage/widgets/sectionheading.dart';
import 'package:qv_patient/view/homepage/widgets/t_primary_continer.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = DocHelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.dark : TColors.light,
      body: SingleChildScrollView(
        child: Column(
          children: [
            FadeInSlide(
              duration: 0.5,
              direction: FadeSlideDirection.ltr,
              child: TPrimaryHeaderContainer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Tsizes.defaultspace),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: Tsizes.spcbtwsections + 20,
                      ),
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadeInSlide(
                                duration: .9,
                                direction: FadeSlideDirection.ltr,
                                child: Text(
                                  "Hello Welcome 👋",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .apply(
                                          color: dark
                                              ? TColors.dark
                                              : TColors.light),
                                ),
                              ),
                              FadeInSlide(
                                duration: 0.9,
                                direction: FadeSlideDirection.ltr,
                                child: Text(
                                  "Sajad.kp",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .apply(
                                          color: dark
                                              ? TColors.dark
                                              : TColors.light),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const FadeInSlide(
                            duration: 0.9,
                            direction: FadeSlideDirection.ltr,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(TImages.user),
                            ),
                          ),
                        ],
                      ),
                      const FadeInSlide(
                          duration: 0.9,
                          direction: FadeSlideDirection.ltr,
                          child: SearchBarModel()),
                      const SizedBox(
                        height: Tsizes.defaultspace + 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const FadeInSlide(
                    duration: 0.9,
                    direction: FadeSlideDirection.ltr,
                    child: TPromoSlider(
                      banners: [
                        TImages.promoBanner1,
                        TImages.promoBanner1,
                        TImages.promoBanner1
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: Tsizes.spcbtwsections,
                  ),
                  const FadeInSlide(
                      duration: 0.9,
                      direction: FadeSlideDirection.ltr,
                      child: TSectionHeading(title: "Nearby Doctors")),
                  const SizedBox(
                    height: Tsizes.spcbtwsections,
                  ),
                  FadeInSlide(
                    duration: 0.9,
                    direction: FadeSlideDirection.ltr,
                    child: DocCard(
                      peoplerated: 45,
                      ratingnumber: 4.0,
                      rating: 4,
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const BookingScreen(
                              doctor: 'Dr.Salman',
                              specialty: 'Orthologist',
                            ),
                          ),
                        );
                      },
                      name: 'Dr.Salman',
                      location: 'Perintalmanna',
                      department: 'Orthologist',
                    ),
                  ),
                  const SizedBox(
                    height: Tsizes.defaultspace,
                  ),
                  FadeInSlide(
                    duration: 0.9,
                    direction: FadeSlideDirection.ltr,
                    child: DocCard(
                      peoplerated: 32,
                      ratingnumber: 3.0,
                      rating: 3,
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const BookingScreen(
                              doctor: 'Dr.Salman',
                              specialty: 'Orthologist',
                            ),
                          ),
                        );
                      },
                      name: 'Dr.Salman',
                      location: 'Perintalmanna',
                      department: 'Orthologist',
                    ),
                  ),
                  const SizedBox(
                    height: Tsizes.defaultspace,
                  ),
                  FadeInSlide(
                    duration: 0.9,
                    direction: FadeSlideDirection.ltr,
                    child: DocCard(
                      peoplerated: 48,
                      ratingnumber: 5,
                      rating: 5,
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const BookingScreen(
                              doctor: 'Dr.Salman',
                              specialty: 'Orthologist',
                            ),
                          ),
                        );
                      },
                      name: 'Dr.Salman',
                      location: 'Perintalmanna',
                      department: 'Orthologist',
                    ),
                  ),
                  const SizedBox(
                    height: Tsizes.defaultspace,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
