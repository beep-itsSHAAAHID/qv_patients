import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qv_patient/navigationmenu.dart';
import 'package:qv_patient/view/Authentication/login_view.dart';
import 'package:qv_patient/view/onboarding/screens/onboarding.dart';
import 'package:qv_patient/view/splashScreen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationCheck extends StatefulWidget {
  @override
  _AuthenticationCheckState createState() => _AuthenticationCheckState();
}

class _AuthenticationCheckState extends State<AuthenticationCheck> {
  bool _isLoading = true;
  bool _showOnboarding = true;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  // Check if onboarding has already been completed
  Future<void> _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? onboardingCompleted = prefs.getBool('onboarding_completed');

    setState(() {
      // If onboarding has been completed, set flag to false, else true
      _showOnboarding = onboardingCompleted == null || !onboardingCompleted;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      SplashScreen();
    }
    // If onboarding is not completed, show onboarding screen
    if (_showOnboarding) {
      return OnboardingScreen(
        onFinish: _completeOnboarding,
      );
    } else {
      // Check Firebase authentication status
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // If the user is authenticated, show the main navigation menu
        return NavigationMenu();
      } else {
        // If user is not authenticated, show the login screen
        return SignInView(); // Replace this with your login screen
      }
    }
  }

  // Mark onboarding as completed
  Future<void> _completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);

    setState(() {
      _showOnboarding = false;
    });
  }
}
