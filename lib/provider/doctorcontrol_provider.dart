import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Provider to fetch all doctors from all clinic documents
final doctorControllerProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  // Fetch all documents from the clinics collection
  final clinicSnapshot =
      await FirebaseFirestore.instance.collection('clinics').get();

  // Initialize an empty list to store all doctors
  List<Map<String, dynamic>> allDoctors = [];

  // Loop through each clinic document
  for (var clinicDoc in clinicSnapshot.docs) {
    final clinicId = clinicDoc.id; // Get the clinic ID
    final clinicData = clinicDoc.data();
    final location =
        clinicData['location'] ?? 'Unknown Location'; // Get the clinic location

    // Fetch the doctors subcollection from the current clinic document
    final doctorsSnapshot = await FirebaseFirestore.instance
        .collection('clinics')
        .doc(clinicId)
        .collection('doctors')
        .get();

    // Loop through each doctor document in the doctors subcollection
    for (var doctorDoc in doctorsSnapshot.docs) {
      final doctorData = doctorDoc.data();

      // Add clinicId and location to the doctor's data
      final doctorWithClinicInfo = {
        'clinicId': clinicId,
        'location': location,
        'availableDays': doctorData['availableDays'] ?? 'Not Available',
        'consultationTimes': doctorData['consultationTimes'] ?? 'Not Available',
        'email': doctorData['email'] ?? 'Not Available',
        'experience': doctorData['experience'] ?? 'Not Available',
        'id': doctorData['id'] ??
            doctorDoc.id, // Use the document ID if 'id' is not present
        'licenseNumber': doctorData['licenseNumber'] ?? 'Not Available',
        'name': doctorData['name'] ?? 'Unknown Doctor',
        'phone': doctorData['phone'] ?? 'Not Available',
        'specialization': doctorData['specialization'] ?? 'General',
      };

      allDoctors.add(doctorWithClinicInfo);
    }
  }

  // Debug: Print all doctors with their clinic IDs and locations to the console
  print("List of all doctors with clinic IDs and locations:");
  for (var doctor in allDoctors) {
    print(doctor);
  }

  return allDoctors;
});
