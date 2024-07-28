import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qv_patient/view/Authentication/login_view.dart';

// Define a StateNotifier for managing settings state
class SettingsNotifier extends StateNotifier<bool> {
  SettingsNotifier() : super(true);

  void toggleLocation(bool value) {
    state = value;
  }

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => SignInView()),
      (Route<dynamic> route) => false,
    );
  }
}

// Create a provider for the SettingsNotifier
final settingsProvider = StateNotifierProvider<SettingsNotifier, bool>((ref) {
  return SettingsNotifier();
});
