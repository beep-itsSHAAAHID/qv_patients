import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/image_url.dart';
import 'package:qv_patient/helper/doc_helper_function.dart';
import 'package:qv_patient/helper/responsive.dart';
import 'package:qv_patient/provider/doctorcontrol_provider.dart';
import 'package:qv_patient/provider/user_provider.dart';
import 'package:qv_patient/view/BookingPage/all_doctors_avil.dart';
import 'package:qv_patient/view/BookingPage/bookingpage.dart';
import 'package:qv_patient/view/NotificationPage/notification_screen.dart';
import 'package:qv_patient/view/homepage/all_category_page.dart';
import 'package:qv_patient/view/homepage/doctor_by_categorypage.dart';
import 'package:qv_patient/view/homepage/widgets/custom_search_bar.dart';
import 'package:qv_patient/view/homepage/widgets/department_container.dart';
import 'package:qv_patient/view/homepage/widgets/promo_slider.dart';
import 'package:qv_patient/view/homepage/widgets/sectionheading.dart';
import 'package:qv_patient/view/homepage/widgets/t_primary_continer.dart';
import 'package:qv_patient/view/homepage/widgets/docCaed.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = DocHelperFunctions.isDarkMode(context);
    final doctorState = ref.watch(doctorControllerProvider);

    List<String> department = [
      'Neurology',
      'Dental',
      'Cardiologist',
      'Psychiatrists',
      'Pediatrician',
      'Dermatologist',
    ];

    List<String> assetIconUrl = [
      'assets/icons/Neurologist.png',
      'assets/icons/Dentist.png',
      'assets/icons/Cardiologist.png',
      'assets/icons/Psychiatrists.png',
      'assets/icons/Pediatrician.png',
      'assets/icons/Dermatologist.png'
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 252, 252, 246),
        body: RefreshIndicator(
          onRefresh: () async {
            // Refreshes the provider, triggering a rebuild with shimmer effect
            ref.invalidate(doctorControllerProvider);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // Header Section with Shimmer Effect
                doctorState.maybeWhen(
                  loading: () => _buildShimmerHeader(context),
                  orElse: () => _buildActualHeader(context, ref, dark),
                ),

                // Promo Slider Section
                doctorState.maybeWhen(
                  loading: () => _buildShimmerPromoSlider(context),
                  orElse: () => _buildPromoSlider(context),
                ),

                // Categories Section with Shimmer
                doctorState.maybeWhen(
                  loading: () => Column(
                    children: [
                      _buildShimmerSectionHeading(), // Shimmer for section heading
                      _buildShimmerCategories(context),
                    ],
                  ),
                  orElse: () => Column(
                    children: [
                      _buildSectionHeading(
                        context,
                        "Browse By Categories",
                        () {
                          Navigator.push(context, CupertinoPageRoute(
                            builder: (context) {
                              return AllCategoriesPage();
                            },
                          ));
                        },
                      ),
                      _buildCategories(context, department, assetIconUrl),
                    ],
                  ),
                ),

                // Nearby Doctors Section with Shimmer Effect
                doctorState.maybeWhen(
                  loading: () => Column(
                    children: [
                      _buildShimmerSectionHeading(), // Shimmer for section heading
                      _buildShimmerDoctors(context),
                    ],
                  ),
                  orElse: () => Column(
                    children: [
                      _buildSectionHeading(
                        context,
                        "Nearby Doctors",
                        () {
                          Navigator.push(context, CupertinoPageRoute(
                            builder: (context) {
                              return const AllDoctorsPage();
                            },
                          ));
                        },
                      ),
                      _buildNearbyDoctors(context, doctorState),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Shimmer Effect for Header
  Widget _buildShimmerHeader(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: Responsive.symmetricPadding(context, 0.01, 0.05),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  height: 20,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Container(
                  width: 100,
                  height: 20,
                  color: Colors.white,
                ),
              ],
            ),
            const Spacer(),
            CircleAvatar(
              radius: Responsive.width(context, 0.06),
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  // Actual Header when data is available
  Widget _buildActualHeader(BuildContext context, WidgetRef ref, bool dark) {
    return TPrimaryHeaderContainer(
      child: Column(
        children: [
          SizedBox(height: Responsive.height(context, 0.03)),
          Padding(
            padding: Responsive.symmetricPadding(context, 0.01, 0.05),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello Welcome 👋",
                      style: Theme.of(context).textTheme.headlineSmall!.apply(
                            color: dark ? TColors.dark : TColors.light,
                          ),
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        final user = ref.watch(userProvider);
                        final userName = user?['fullName'] ?? "User";

                        return Text(
                          userName,
                          style:
                              Theme.of(context).textTheme.headlineMedium!.apply(
                                    color: dark ? TColors.dark : TColors.light,
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
                  icon: const Icon(Iconsax.notification),
                ),
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
            padding: Responsive.symmetricPadding(context, 0.01, 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomSearchBar(),
                ),
              ],
            ),
          ),
          SizedBox(height: Responsive.height(context, 0.05)),
        ],
      ),
    );
  }

  // Shimmer Effect for Promo Slider with Correct Height
  Widget _buildShimmerPromoSlider(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        height: Responsive.height(context, 0.25),
        color: Colors.white,
      ),
    );
  }

  // Actual Promo Slider
  Widget _buildPromoSlider(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: TPromoSlider(
        banners: [
          TImages.promoBanner1,
          TImages.promoBanner1,
          TImages.promoBanner1,
        ],
      ),
    );
  }

  // Shimmer Effect for Categories with Matching Sizes
  Widget _buildShimmerCategories(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        padding: EdgeInsets.all(Responsive.width(context, 0.02)),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: Responsive.width(context, 0.02),
          mainAxisSpacing: Responsive.height(context, 0.01),
        ),
        itemCount: 6, // Same as the number of departments
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            height: Responsive.height(context, 0.15),
            width: Responsive.width(context, 0.3),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      ),
    );
  }

  // Actual Categories
  Widget _buildCategories(BuildContext context, List<String> department,
      List<String> assetIconUrl) {
    return GridView.builder(
      padding: EdgeInsets.all(Responsive.width(context, 0.02)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: Responsive.width(context, 0.02),
        mainAxisSpacing: Responsive.height(context, 0.01),
      ),
      itemCount: department.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(context, CupertinoPageRoute(
              builder: (context) {
                return DoctorsByCategoryPage(
                  category: department[index],
                );
              },
            ));
          },
          child: DepartmentContainer(
            assetimgurl: assetIconUrl[index],
            departmentName: department[index],
          ),
        );
      },
    );
  }

  // Shimmer Effect for Section Heading (TSectionHeading)
  Widget _buildShimmerSectionHeading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          height: 20,
          width: 150,
          color: Colors.white,
        ),
      ),
    );
  }

  // Actual Section Heading (TSectionHeading)
  Widget _buildSectionHeading(
      BuildContext context, String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TSectionHeading(
        title: title,
        textColor: TColors.black,
        showActionButton: true,
        onPressed: onPressed,
      ),
    );
  }

  // Shimmer Effect for Nearby Doctors with Correct Sizes
  Widget _buildShimmerDoctors(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 8),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5, // Number of doctors to show while loading
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
      ),
    );
  }

  // Actual Nearby Doctors List
  Widget _buildNearbyDoctors(BuildContext context, AsyncValue doctorState) {
    return doctorState.when(
      loading: () => _buildShimmerDoctors(context),
      error: (err, stack) => Center(child: Text("Error: $err")),
      data: (doctors) {
        if (doctors.isEmpty) {
          return Center(child: Text("No doctors found."));
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 8),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: doctors.length,
          itemBuilder: (context, index) {
            final doctor = doctors[index];

            // Safely access the fields and provide default values if necessary
            final name = doctor['name'] ?? 'Unknown Doctor';
            final specialization =
                doctor['specialization'] ?? 'No specialization';
            final clinicId = doctor['clinicId'] ?? '';
            final location = doctor['location'] ?? 'Unknown Location';
            final rating = (doctor['rating'] ?? 4.0) as double;
            final docid = doctor['id'] ?? '';
            final ratingNumber = (doctor['ratingNumber'] ?? 4.0) as double;
            final peopleRated = (doctor['peopleRated'] ?? 0) as int;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: DocCard(
                onTap: () {
                  Navigator.push(context, CupertinoPageRoute(
                    builder: (context) {
                      return BookingScreen(
                          doctor: name,
                          specialty: specialization,
                          clinicId: clinicId,
                          location,
                          docid);
                    },
                  ));
                },
                name: name,
                department: specialization,
                location: location,
                rating: rating,
                ratingnumber: ratingNumber,
                peoplerated: peopleRated,
              ),
            );
          },
        );
      },
    );
  }
}
