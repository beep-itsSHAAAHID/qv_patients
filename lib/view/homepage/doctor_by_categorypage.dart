import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/provider/doctorcontrol_provider.dart';
import 'package:qv_patient/view/homepage/widgets/docCaed.dart';

class DoctorsByCategoryPage extends ConsumerStatefulWidget {
  final String category;

  const DoctorsByCategoryPage({required this.category, Key? key})
      : super(key: key);

  @override
  _DoctorsByCategoryPageState createState() => _DoctorsByCategoryPageState();
}

class _DoctorsByCategoryPageState extends ConsumerState<DoctorsByCategoryPage> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final doctorState = ref.watch(doctorControllerProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 252, 246),
      appBar: AppBar(
        title: Text(
          widget.category,
          style: const TextStyle(color: TColors.black),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: const TextStyle(color: TColors.black),
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search doctors ...',
                hintStyle: const TextStyle(color: TColors.black),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            ),
          ),
          Expanded(
            child: doctorState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text("Error: $err")),
              data: (doctors) {
                // Filter doctors based on the category and search query
                final filteredDoctors = doctors.where((doctor) {
                  final specialization =
                      doctor['specialization']?.toString() ?? '';
                  final name = doctor['name']?.toString() ?? '';

                  return specialization == widget.category &&
                      name.toLowerCase().contains(_searchQuery.toLowerCase());
                }).toList();

                if (filteredDoctors.isEmpty) {
                  return const Center(
                      child: Text(
                    "No doctors found in this category.",
                    style: TextStyle(color: TColors.black),
                  ));
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: filteredDoctors.length,
                  itemBuilder: (context, index) {
                    final doctor = filteredDoctors[index];

                    // Safely access the fields and provide default values if necessary
                    final name = doctor['name']?.toString() ?? 'Unknown Doctor';
                    final specialization =
                        doctor['specialization']?.toString() ??
                            'No specialization';
                    final location =
                        doctor['location']?.toString() ?? 'Unknown Location';
                    final rating = (doctor['rating'] as double?) ?? 4.0;
                    final ratingNumber =
                        (doctor['ratingNumber'] as double?) ?? 4.0;
                    final peopleRated = (doctor['peopleRated'] as int?) ?? 0;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: DocCard(
                        onTap: () {
                          // Handle doctor selection if needed
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
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
