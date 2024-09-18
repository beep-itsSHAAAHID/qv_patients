import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/provider/doctorcontrol_provider.dart';
import 'package:qv_patient/view/BookingPage/bookingpage.dart';
import 'package:qv_patient/view/homepage/widgets/custom_search_bar.dart';
import 'package:qv_patient/view/homepage/widgets/docCaed.dart';

class AllDoctorsPage extends ConsumerWidget {
  const AllDoctorsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorState = ref.watch(doctorControllerProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 252, 252, 246),
        appBar: AppBar(
          title: Text(
            'All Doctors',
            style: TextStyle(color: TColors.black),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomSearchBar(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: doctorState.when(
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text("Error: $err")),
                  data: (doctors) {
                    if (doctors.isEmpty) {
                      return Center(child: Text("No doctors found."));
                    }

                    return ListView.builder(
                      itemCount: doctors.length,
                      itemBuilder: (context, index) {
                        var doctor = doctors[index];
                        return Column(
                          children: [
                            const SizedBox(height: 20),
                            DocCard(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => BookingScreen(
                                        doctor: doctor['name'],
                                        clinicId: doctor['clinicId'] ?? '',
                                        specialty: doctor['specialization'],
                                        doctor['location'] ??
                                            'Unknown Location',
                                        doctor['id'] ?? ''),
                                  ),
                                );
                              },
                              name: doctor['name'],
                              department: doctor['specialization'],
                              rating: (doctor['rating'] ?? 5.0)
                                  as double, // Placeholder value
                              ratingnumber: (doctor['ratingNumber'] ?? 5.0)
                                  as double, // Placeholder value
                              peoplerated: (doctor['peopleRated'] ?? 32)
                                  as int, // Placeholder value
                              location:
                                  doctor['location'] ?? 'Unknown Location',
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
