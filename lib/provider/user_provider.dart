import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserNotifier extends StateNotifier<Map<String, dynamic>?> {
  UserNotifier() : super(null) {
    // Listen to auth state changes to automatically handle user data updates
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        // User has logged out
        _clearUserData();
      } else {
        // User has logged in
        _updateUserData();
      }
    });
  }

  void updateUserInformation() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Assuming patientId is stored as a custom claim or somewhere accessible
        final patientId = await _fetchPatientId(user.email);

        if (patientId != null) {
          // Fetch the user document from Firestore using the patientId as the document ID
          final userDoc = await FirebaseFirestore.instance
              .collection('patients')
              .doc(patientId)
              .get();

          // Fetch the relevant fields from the user document
          final userData = userDoc.data();
          if (userData != null) {
            state = {
              'fullName': userData['fullName'] ?? 'User',
              'age': userData['age'] ?? '',
              'email': userData['email'] ?? '',
              'gender': userData['gender'] ?? '',
              'patientId': userData['patientId'] ?? '',
              'phoneNumber': userData['phoneNumber'] ?? '',
              'profilePicUrl': userData['profilePicUrl'] ??
                  'https://example.com/default-profile-pic.png',
            };
          } else {
            // Handle the case where the document is null
            print("User data is null or not found in the document.");
            state = {'fullName': 'User'}; // Optionally set a default value
          }
        } else {
          print("Patient ID is null or not found.");
          // Handle the case where the patient ID is not available
        }
      } catch (e) {
        print("Error fetching user data: $e");
        // Handle any errors that occur during fetch
      }
    } else {
      print("User is not logged in.");
      // Handle the case where the user is not logged in
    }
  }

  Future<String?> _fetchPatientId(String? email) async {
    if (email != null) {
      try {
        // Query the Firestore collection to find the patient document by email
        final querySnapshot = await FirebaseFirestore.instance
            .collection('patients')
            .where('email', isEqualTo: email)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          return querySnapshot.docs.first.id; // Return the document ID (patientId)
        }
      } catch (e) {
        print("Error fetching patient ID: $e");
      }
    }
    return null;
  }

  void _clearUserData() {
    // Clear or reset user-related data upon logout
    state = null;
  }

  void _updateUserData() async {
    updateUserInformation();
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, Map<String, dynamic>?>((ref) {
  return UserNotifier();
});
