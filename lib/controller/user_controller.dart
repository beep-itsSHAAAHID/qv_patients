import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qv_patient/view/Authentication/login_view.dart';

class UserController extends GetxController {
  Rxn<String> userName = Rxn<String>(); // This will hold the user's name

  @override
  void onInit() {
    super.onInit();
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
    final email = FirebaseAuth.instance.currentUser?.email; // Get the current user's email
    if (email != null) {
      try {
        // Fetch the user document from Firestore using the email
        final userDoc = await FirebaseFirestore.instance.collection('users').doc(email).get();
        final fullName = userDoc.data()?['fullName'] as String?; // Get the fullName field

        if (fullName != null) {
          userName.value = fullName; // Update the userName observable with the fetched name
        } else {
          // Handle the case where fullName is null or missing
          print("FullName is null or not found in the document.");
          userName.value = "User"; // Optionally set a default value or handle as needed
        }
      } catch (e) {
        print("Error fetching user name: $e");
        // Handle any errors that occur during fetch
      }
    } else {
      print("User email is null");
      // Handle the case where the user's email is not available
    }
  }

  void _clearUserData() {
    // Clear or reset user-related data upon logout
    userName.value = null;
  }

  void _updateUserData() async {
    final email = FirebaseAuth.instance.currentUser?.email;
    if (email != null) {
      try {
        // Attempt to fetch user data from Firestore based on the user's email
        final userDoc = await FirebaseFirestore.instance.collection('users').doc(email).get();
        final fullName = userDoc.data()?['fullName'] as String?;
        if (fullName != null) {
          userName.value = fullName;
        } else {
          // Handle the case where the full name is not set
          userName.value = "User";
        }
      } catch (e) {
        // Handle errors in fetching user data
        print("Error fetching user name: $e");
      }
    }
  }
}
