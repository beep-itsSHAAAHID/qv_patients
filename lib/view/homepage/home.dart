import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/image_url.dart';
import 'package:qv_patient/helper/doc_helper_function.dart';
import 'package:qv_patient/helper/responsive.dart';
import 'package:qv_patient/provider/user_provider.dart';
import 'package:qv_patient/view/BookingPage/all_doctors_avil.dart';
import 'package:qv_patient/view/BookingPage/bookingpage.dart';
import 'package:qv_patient/view/NotificationPage/notification_screen.dart';
import 'package:qv_patient/view/homepage/all_category_page.dart';
import 'package:qv_patient/view/homepage/widgets/custom_search_bar.dart';
import 'package:qv_patient/view/homepage/widgets/department_container.dart';
import 'package:qv_patient/view/homepage/widgets/docCaed.dart';
import 'package:qv_patient/view/homepage/widgets/promo_slider.dart';
import 'package:qv_patient/view/homepage/widgets/sectionheading.dart';
import 'package:qv_patient/view/homepage/widgets/t_primary_continer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Method to refresh data
  Future<void> _refreshData() async {
    setState(() {
      // You can add any additional logic here if needed.
      // Currently, it just refreshes the state to trigger a rebuild.
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> department = [
      'Neurologist',
      'Dentist',
      'Cardiologist',
      'Psychiatrists',
      'Pediatrician',
      'Dermatologist',
      // 'Ophthalmology',
      // 'Gynecologist',
      // 'Orthopedic',
      // 'Radiologist',
      // 'Oncologist',
      // 'Anesthesiologist',
      // 'ENT Specialist',
      // 'Gastroenterologist',
      // 'Nephrologist',
      // 'Urologist',
    ];
    List<String> asseticonurl = [
      'assets/icons/Neurologist.png',
      'assets/icons/Dentist.png',
      'assets/icons/Cardiologist.png',
      'assets/icons/Psychiatrists.png',
      'assets/icons/Pediatrician.png',
      'assets/icons/Dermatologist.png'
    ];

    final dark = DocHelperFunctions.isDarkMode(context);

    Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
        fetchDoctors() async {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('doctors').get();
      return querySnapshot.docs;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 252, 252, 246),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TPrimaryHeaderContainer(
                    child: Column(
                      children: [
                        SizedBox(height: Responsive.height(context, 0.03)),
                        Padding(
                          padding:
                              Responsive.symmetricPadding(context, 0.01, 0.05),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hello Welcome 👋",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .apply(
                                          color: dark
                                              ? TColors.dark
                                              : TColors.light,
                                        ),
                                  ),
                                  Consumer(
                                    builder: (context, ref, child) {
                                      final userName = ref.watch(userProvider);
                                      return Text(
                                        userName ?? "User",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .apply(
                                              color: dark
                                                  ? TColors.dark
                                                  : TColors.light,
                                            ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(context, CupertinoPageRoute(
                                      builder: (context) {
                                        return NotificationPage();
                                      },
                                    ));
                                  },
                                  icon: const Icon(Iconsax.notification)),
                              const SizedBox(width: 8),
                              CircleAvatar(
                                radius: Responsive.width(context, 0.06),
                                backgroundImage: const AssetImage(TImages.user),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Responsive.height(context, 0.02)),
                        Padding(
                          padding:
                              Responsive.symmetricPadding(context, 0.01, 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child:
                                    CustomSearchBar(), // Use the custom search bar without a controller
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Responsive.height(context, 0.05)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: Responsive.symmetricPadding(context, 0.0, 0.05),
                    child: Column(
                      children: [
                        TPromoSlider(
                          banners: [
                            TImages.promoBanner1,
                            TImages.promoBanner1,
                            TImages.promoBanner1,
                          ],
                        ),
                        TSectionHeading(
                          textColor: TColors.black,
                          title: "Browse By Categories",
                          showActionButton: true,
                          onPressed: () {
                            Navigator.push(context, CupertinoPageRoute(
                              builder: (context) {
                                return AllCategoriesPage();
                              },
                            ));
                          },
                        ),
                        GridView.builder(
                          padding:
                              EdgeInsets.all(Responsive.width(context, 0.02)),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: Responsive.width(context, 0.02),
                            mainAxisSpacing: Responsive.height(context, 0.01),
                          ),
                          itemCount: department.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return DepartmentContainer(
                                assetimgurl: asseticonurl[index],
                                departmentName: department[index]);
                          },
                        ),
                        SizedBox(height: Responsive.height(context, 0.01)),
                        TSectionHeading(
                          title: "Nearby Doctors",
                          textColor: TColors.black,
                          onPressed: () {
                            Navigator.push(context,
                                CupertinoPageRoute(builder: (context) {
                              return const AllDoctorsPage();
                            }));
                          },
                        ),
                        FutureBuilder<List<QueryDocumentSnapshot>>(
                          future: fetchDoctors(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: LoadingAnimationWidget.dotsTriangle(
                                      color: TColors.primary, size: 20));
                            }
                            if (snapshot.hasError) {
                              return const Text("Error fetching data");
                            }
                            if (snapshot.hasData) {
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  var doc = snapshot.data![index].data()
                                      as Map<String, dynamic>;
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: DocCard(
                                      peoplerated: 45, // Placeholder value
                                      ratingnumber: 4.0, // Placeholder value
                                      rating: 4, // Placeholder value
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) => BookingScreen(
                                              doctor: doc['doctorName'],
                                              specialty:
                                                  doc['doctorSpeciality'],
                                            ),
                                          ),
                                        );
                                      },
                                      name: doc['doctorName'],
                                      department: doc['doctorSpeciality'],
                                      location: 'Test',
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Text("No doctors found");
                            }
                          },
                        ),
                        SizedBox(height: Responsive.height(context, 0.03)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
