import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/loading_overlay.dart';
import 'package:qv_patient/navigationmenu.dart';
import 'package:qv_patient/view/Authentication/forgot_password_view.dart';
import 'package:qv_patient/view/Authentication/widgets/widgets.dart';

import '../../controller/user_controller.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  ValueNotifier<bool> termsCheck = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;

    Future<void> signInUser() async {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => Center(child: CircularProgressIndicator()),
      );

      try {
        // Authenticate with Firebase Authentication
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Retrieve user profile from Firestore using email as document ID
        DocumentSnapshot userProfile = await FirebaseFirestore.instance.collection('users').doc(_emailController.text.trim()).get();

        if (!userProfile.exists) {
          throw Exception("User profile does not exist in Firestore.");
        }

        // Here, we manually trigger the UserController to update the user's name
        final userController = Get.find<UserController>();
        userController.updateUserInformation(); // This should fetch and update the user's name

        // Dismiss loading dialog
        Navigator.of(context).pop();

        // Navigate to next page if everything is okay
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => const NavigationMenu()),
        );

      } on FirebaseAuthException catch (e) {
        Navigator.of(context).pop(); // Ensure loading indicator is closed on error

        // Handle Firebase Authentication errors (e.g., wrong password, user not found)
        String errorMessage = "An error occurred during sign in. Please try again.";
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided.';
        }

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
      } catch (e) {
        Navigator.of(context).pop(); // Ensure loading indicator is closed on error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }





    return Scaffold(
      appBar: AppBar(),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const FadeInSlide(
              duration: .4,
              child: Text(
                "Welcome Back! 👋",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            const SizedBox(height: 15),
            const FadeInSlide(
              duration: .5,
              child: Text(
                "Your Digital Hospital",
              ),
            ),
            const SizedBox(height: 25),
            const FadeInSlide(
              duration: .6,
              child: Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
             FadeInSlide(duration: .6, child: EmailField(
              controller: _emailController,
            )),
            const SizedBox(height: 20),
            const FadeInSlide(
              duration: .7,
              child: Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
             FadeInSlide(duration: .7, child: PasswordField(
              controller: _passwordController,
            )),
            const SizedBox(height: 20),
            FadeInSlide(
              duration: .8,
              child: Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: termsCheck,
                    builder: (context, value, child) {
                      return CupertinoCheckbox(
                        inactiveColor: isDark ? Colors.white : Colors.black87,
                        value: value,
                        onChanged: (_) {
                          termsCheck.value = !termsCheck.value;
                        },
                      );
                    },
                  ),
                  const Text(
                    "Remember Me",
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const ForgotPasswordView(),
                      ),
                    ),
                    child: const Text("Forgot Password?"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const FadeInSlide(
              duration: .9,
              child: Row(
                children: [
                  Expanded(
                      child: Divider(
                    thickness: .3,
                  )),
                  Text(
                    "   or   ",
                    // style: context.tm,
                  ),
                  Expanded(
                      child: Divider(
                    thickness: .3,
                  )),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FadeInSlide(
              duration: 1,
              child: LoginButton(
                icon: Brand(Brands.google, size: 25),
                text: "Continue with Google",
                onPressed: () {},
              ),
            ),
            SizedBox(height: height * 0.02),
            FadeInSlide(
              duration: 1.1,
              child: LoginButton(
                icon: Icon(
                  Icons.apple,
                  color: isDark ? Colors.white : Colors.black,
                ),
                text: "Continue with Apple",
                onPressed: () {},
              ),
            ),
            SizedBox(height: height * 0.02),
            // FadeInSlide(
            //   duration: 1.2,
            //   child: LoginButton(
            //     icon: Brand(Brands.facebook, size: 25),
            //     text: "Continue with Facebook",
            //     onPressed: () {},
            //   ),
            // ),
            // SizedBox(height: height * 0.02),
            // FadeInSlide(
            //   duration: 1.3,
            //   child: LoginButton(
            //     icon: Brand(Brands.twitter, size: 25),
            //     text: "Continue with Twitter",
            //     onPressed: () {},
            //   ),
            // ),
          ]
          // .animate(interval: 10.ms).slide(
          //     begin: const Offset(0, -40),
          //     end: Offset.zero,
          //     // curve: Curves.easeOut,
          //     duration: 1200.ms,
          //     delay: 200.ms),
          ),
      bottomNavigationBar: FadeInSlide(
        duration: 1,
        direction: FadeSlideDirection.btt,
        child: Container(
          padding:
              const EdgeInsets.only(bottom: 40, left: 20, right: 20, top: 30),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: .2, color: Colors.grey),
            ),
          ),
          child: FilledButton(
            onPressed: () async {
              signInUser();
            },
            style: FilledButton.styleFrom(
              backgroundColor: TColors.primary,
              fixedSize: const Size(double.infinity, 50),
            ),
            child: const Text(
              "Sign In",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ),
      ),
    );
  }
}
