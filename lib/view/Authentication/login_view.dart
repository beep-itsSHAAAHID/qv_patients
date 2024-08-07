import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/loading_overlay.dart';
import 'package:qv_patient/helper/responsive.dart';
import 'package:qv_patient/navigationmenu.dart';
import 'package:qv_patient/view/Authentication/forgot_password_view.dart';
import 'package:qv_patient/view/Authentication/widgets/widgets.dart';
import 'package:qv_patient/provider/user_provider.dart'; // Import the provider

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

    Future<void> signInUser(WidgetRef ref) async {
      // Show loading indicator
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

      try {
        // Authenticate with Firebase Authentication
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Retrieve user profile from Firestore using email as document ID
        DocumentSnapshot userProfile = await FirebaseFirestore.instance
            .collection('users')
            .doc(_emailController.text.trim())
            .get();

        if (!userProfile.exists) {
          throw Exception("User profile does not exist in Firestore.");
        }

        // Here, we manually trigger the UserController to update the user's name
        final userNotifier = ref.read(userProvider.notifier);
        userNotifier
            .updateUserInformation(); // This should fetch and update the user's name

        // Dismiss loading dialog
        Navigator.of(context).pop();

        // Navigate to next page if everything is okay
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => const NavigationMenu()),
        );
      } on FirebaseAuthException catch (e) {
        Navigator.of(context)
            .pop(); // Ensure loading indicator is closed on error

        // Handle Firebase Authentication errors (e.g., wrong password, user not found)
        String errorMessage =
            "An error occurred during sign in. Please try again.";
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: TColors.error,
            content: Text(
              errorMessage,
            ),
          ),
        );
      } catch (e) {
        Navigator.of(context)
            .pop(); // Ensure loading indicator is closed on error
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 252, 246),
      appBar: AppBar(),
      body: Consumer(
        builder: (context, ref, child) {
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              FadeInSlide(
                duration: .4,
                child: Text(
                  "Welcome Back! 👋",
                  style: TextStyle(
                      color: TColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: Responsive.fontSize(context, 0.06)),
                ),
              ),
              const SizedBox(height: 15),
              FadeInSlide(
                duration: .5,
                child: Text(
                  "Your Digital Hospital",
                  style: TextStyle(
                      color: TColors.black,
                      fontSize: Responsive.fontSize(context, 0.04)),
                ),
              ),
              const SizedBox(height: 25),
              const FadeInSlide(
                duration: .6,
                child: Text(
                  "Email",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: TColors.black),
                ),
              ),
              const SizedBox(height: 10),
              FadeInSlide(
                duration: .6,
                child: EmailField(
                  icon: IconlyLight.message,
                  controller: _emailController,
                ),
              ),
              const SizedBox(height: 20),
              const FadeInSlide(
                duration: .7,
                child: Text(
                  "Password",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: TColors.black),
                ),
              ),
              const SizedBox(height: 10),
              FadeInSlide(
                duration: .7,
                child: PasswordField(
                  controller: _passwordController,
                ),
              ),
              const SizedBox(height: 20),
              FadeInSlide(
                duration: .8,
                child: Row(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: termsCheck,
                      builder: (context, value, child) {
                        return CupertinoCheckbox(
                          inactiveColor: Colors.black87,
                          value: value,
                          onChanged: (_) {
                            termsCheck.value = !termsCheck.value;
                          },
                        );
                      },
                    ),
                    const Text(
                      "Remember Me",
                      style: TextStyle(color: TColors.black),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const ForgotPasswordView(),
                        ),
                      ),
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: TColors.primary),
                      ),
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
                      style: TextStyle(color: TColors.black),
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
            ],
          );
        },
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
          child: Consumer(
            builder: (context, ref, child) {
              return FilledButton(
                onPressed: () async {
                  await signInUser(ref);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: TColors.primary,
                  fixedSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                      fontWeight: FontWeight.w900, color: TColors.white),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
