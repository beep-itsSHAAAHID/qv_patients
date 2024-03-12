import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/view/BookingPage/bookingpage.dart';
import 'package:qv_patient/view/homepage/widgets/docCaed.dart';

class AllDoctorsPage extends StatelessWidget {
  const AllDoctorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Doctors'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.search_favorite_outline),
                  hintText: 'Search Your Doctors...',
                  filled: true,
                  fillColor: TColors.light.withOpacity(0.1)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView.builder(
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      DocCard(
                        onTap: () {
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (context) {
                            return const BookingScreen(
                              doctor: 'Salaman',
                              specialty: 'Dentist',
                            );
                          }));
                        },
                        name: 'Salaman',
                        location: 'pmna',
                        department: 'Dentist',
                        rating: 5,
                        ratingnumber: 5,
                        peoplerated: 32,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}