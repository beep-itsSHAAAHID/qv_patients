import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qv_patient/model/globalvariable.dart';
import 'package:qv_patient/view/onboarding/onboarding1.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xFF315098),
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: OnboardingScreen());
  }
}
