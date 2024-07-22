import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qv_patient/services/notification_service.dart';
import 'package:qv_patient/theme/theme.dart';
import 'package:qv_patient/view/onboarding/screens/onboarding.dart';
import 'firebase_options.dart';
import 'navigationmenu.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle());

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final messagingService = FirebaseMessagingService();
  messagingService.initializeMessaging();

  String? token = await FirebaseMessaging.instance.getToken();
  print("Firebase Messaging Token: $token");

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    _getFCMToken();
    return MaterialApp(

      title: 'QV Patient App',
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      debugShowCheckedModeBanner: false,
      home: AuthenticationWrapper(),
    );
  }
}

void _getFCMToken() async {
  try {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    print("FCM Token: $token");
  } catch (e) {
    print("Failed to get FCM Token: $e");
  }
}

class AuthenticationWrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Future.microtask(() => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const NavigationMenu()),
          ));
          return const SizedBox.shrink(); // More explicit empty widget.
        } else {
          return OnboardingScreen();
        }
      },
    );
  }
}
