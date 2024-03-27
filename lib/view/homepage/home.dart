import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/image_url.dart';
import 'package:qv_patient/constants/size.dart';
import 'package:qv_patient/helper/doc_helper_function.dart';
import 'package:qv_patient/model/searchbar.dart';
import 'package:qv_patient/view/BookingPage/all_doctors_avil.dart';
import 'package:qv_patient/view/BookingPage/bookingpage.dart';
import 'package:qv_patient/view/homepage/AiDoctor/ai_doctor.dart';
import 'package:qv_patient/view/homepage/widgets/docCaed.dart';
import 'package:qv_patient/view/homepage/widgets/promo_slider.dart';
import 'package:qv_patient/view/homepage/widgets/sectionheading.dart';
import 'package:qv_patient/view/homepage/widgets/t_primary_continer.dart';

import '../../controller/user_controller.dart';


class Home extends StatelessWidget {



  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<dynamic> department = [
      'Neurologist',
      "Dentist",
      "Cardiologist",
      "Psychiatrists"
    ];
    final UserController userController = Get.find<UserController>(); // Get the UserController instance
    final dark = DocHelperFunctions.isDarkMode(context);


    Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchDoctors() async {
      final querySnapshot = await FirebaseFirestore.instance.collection('doctors').get();
      return querySnapshot.docs;
    }



    return Scaffold(
      backgroundColor: dark ? TColors.dark : TColors.light,
      body: SingleChildScrollView(
        child: FadeInSlide(
          direction: FadeSlideDirection.ltr,
          duration: 0.9,
          child: Column(
            children: [
              TPrimaryHeaderContainer(
                child: Column(
                  children: [
                    const SizedBox(
                      height: Tsizes.spcbtwsections + 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Tsizes.defaultspace),
                      child: Row(
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hello Welcome 👋",
                                  style: Theme.of(context).textTheme.headlineSmall!.apply(color: dark ? TColors.dark : TColors.light),
                                ),
                                Obx(() {
                                  final UserController userController = Get.find<UserController>();
                                  return Text(
                                    userController.userName.value ?? "User", // Dynamically display the user's name
                                    style: Theme.of(context).textTheme.headlineMedium!.apply(
                                        color: dark ? TColors.dark : TColors.light),
                                  );
                                }),


                              ],
                          ),
                          const Spacer(),
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(TImages.user),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Tsizes.defaultspace),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SearchBarModel(),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(CupertinoPageRoute(builder: (ctx) {
                                return ChatBot();
                              }));
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: TColors.dark,
                              backgroundImage:
                                  AssetImage('assets/image/chatbot.png'),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: Tsizes.defaultspace,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          4,
                          (index) => Column(
                            children: [
                              Container(
                                child: Center(
                                    child: Text(
                                  department[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .apply(
                                          color: dark
                                              ? TColors.dark
                                              : TColors.light),
                                )),
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: dark
                                      ? TColors.dark.withOpacity(0.3)
                                      : TColors.light.withOpacity(0.3),
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 7),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    TPromoSlider(
                      banners: [
                        TImages.promoBanner1,
                        TImages.promoBanner1,
                        TImages.promoBanner1
                      ],
                    ),
                    const SizedBox(
                      height: Tsizes.spcbtwsections,
                    ),
                    TSectionHeading(
                      title: "Nearby Doctors",
                      onPressed: () {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (context) {
                          return const AllDoctorsPage();
                        }));
                      },
                    ),
                    // const SizedBox(
                    //   height: Tsizes.spcbtwsections,
                    // ),
                    FutureBuilder<List<QueryDocumentSnapshot>>(
                      future: fetchDoctors(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Text("Error fetching data");
                        }
                        if (snapshot.hasData) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var doc = snapshot.data![index].data() as Map<String, dynamic>;
                              return DocCard(
                                peoplerated: 45, // Placeholder value
                                ratingnumber: 4.0, // Placeholder value
                                rating: 4, // Placeholder value
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => BookingScreen(
                                        doctor: doc['doctorName'],
                                        specialty: doc['doctorSpeciality'],
                                      ),
                                    ),
                                  );
                                },
                                name: doc['doctorName'],
                                department: doc['doctorSpeciality'], location: 'Test',
                              );
                            },
                          );
                        } else {
                          return Text("No doctors found");
                        }
                      },
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
      ),
    );
  }
}
