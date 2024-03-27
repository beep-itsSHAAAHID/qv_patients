import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/view/BookingPage/bookingpage.dart';


import '../homepage/widgets/docCaed.dart';

class AllDoctorsPage extends StatelessWidget {
  const AllDoctorsPage({Key? key}) : super(key: key);

  Future<List<QueryDocumentSnapshot>> fetchDoctors() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('doctors').get();
    return querySnapshot.docs;
  }

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
                fillColor: TColors.light.withOpacity(0.1),
              ),
              // Implement onChange for searching and filtering
              // onChange: (value) => // Your search handling logic here
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: FutureBuilder<List<QueryDocumentSnapshot>>(
                future: fetchDoctors(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var doc = snapshot.data![index].data() as Map<String, dynamic>;
                        return Column(
                          children: [
                            const SizedBox(height: 20),
                            DocCard(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => BookingScreen(
                                      doctor: doc['doctorName'],
                                      specialty: doc['doctorSpeciality'],
                                      // location: doc['doctorLocation'], // If location is added back later
                                    ),
                                  ),
                                );
                              },
                              name: doc['doctorName'],
                              department: doc['doctorSpeciality'],
                              rating: 5, // Placeholder value, adjust as needed
                              ratingnumber: 5.0, // Placeholder value, adjust as needed
                              peoplerated: 32, location: 'test', // Placeholder value, adjust as needed
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Text("No doctors found");
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
