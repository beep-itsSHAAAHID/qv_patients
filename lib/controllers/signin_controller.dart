import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/helper/responsive.dart';
import 'package:qv_patient/navigationmenu.dart';
import 'package:qv_patient/provider/user_provider.dart';

class SigninController {
  final ValueNotifier<bool> termsCheck = ValueNotifier(false);

  // Show a loading dialog while signing in
  Future<void> _showLoadingDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => Center(
        child: LoadingAnimationWidget.dotsTriangle(
          color: TColors.primary,
          size: Responsive.width(context, 0.1),
        ),
      ),
    );
  }

  // Handle the user sign-in process
  Future<bool> signInUser(
      WidgetRef ref,
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController) async {
    // Validate email and password
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      _showSnackbar("Please enter both email and password.", context);
      return false;
    }

    _showLoadingDialog(context); // Show loading dialog

    try {
      // Sign in using Firebase Auth
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Retrieve the user document from Firestore
      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection('patients')
          .where('email', isEqualTo: emailController.text.trim())
          .get();

      if (userQuery.docs.isEmpty) {
        throw Exception("User document does not exist in Firestore.");
      }

      // Get the first matching document
      DocumentSnapshot userDoc = userQuery.docs.first;
      String patientId = userDoc.get('patientId') as String;

      if (patientId.isEmpty) {
        throw Exception("PatientID field is empty in Firestore.");
      }

      // Retrieve the patient profile from the patients collection
      DocumentSnapshot patientProfile = await FirebaseFirestore.instance
          .collection('patients')
          .doc(patientId)
          .get();

      if (!patientProfile.exists) {
        throw Exception("Patient profile does not exist in Firestore.");
      }

      // Update the user information in the provider
      final userNotifier = ref.read(userProvider.notifier);
      userNotifier.updateUserInformation();

      Navigator.of(context).pop(); // Close loading dialog
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => const NavigationMenu()),
      );
      return true; // Sign-in successful
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop(); // Ensure loading dialog is closed
      _handleAuthError(e, context);
      return false; // Sign-in failed
    } catch (e) {
      Navigator.of(context).pop(); // Ensure loading dialog is closed
      _showSnackbar(e.toString(), context);
      return false; // Sign-in failed
    }
  }

  // Handle authentication errors and show appropriate messages
  void _handleAuthError(FirebaseAuthException e, BuildContext context) {
    String errorMessage = "An error occurred during sign in. Please try again.";
    if (e.code == 'user-not-found') {
      errorMessage = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      errorMessage = 'Wrong password provided.';
    }
    _showSnackbar(errorMessage, context);
  }

  // Show a snackbar for displaying messages
  void _showSnackbar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: TColors.error,
        content: Text(message),
      ),
    );
  }
}
