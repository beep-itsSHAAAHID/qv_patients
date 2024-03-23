import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:qv_patient/theme/theme.dart';
import 'package:qv_patient/view/onboarding/screens/onboarding.dart';
import 'controller/user_controller.dart';
import 'firebase_options.dart';
import 'navigationmenu.dart';

// Assuming UserController is defined in another file.
// import 'path_to_your_user_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle());
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize UserController here so it's available app-wide.
  Get.put(UserController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Directly navigate to NavigationMenu, assuming the user is logged in.
          Future.microtask(() => Get.offAll(() => const NavigationMenu()));
          return Container(); // Temporarily return an empty Container
        } else {
          // Navigate to OnboardingScreen if not logged in.
          return OnboardingScreen();
        }
      },
    );
  }
}
