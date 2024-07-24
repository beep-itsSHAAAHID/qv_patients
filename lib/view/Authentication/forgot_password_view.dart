import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/loading_overlay.dart';
import 'package:qv_patient/helper/responsive.dart';
import 'package:qv_patient/view/Authentication/otp_input_view.dart';

import '../../animations/fade_in_slide.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 252, 246),
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          FadeInSlide(
            duration: .4,
            child: Text(
              "Forgot Your Password 🔑",
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
              "We've got you covered. Enter your registered email to reset your password. We will send an OTP code to your email for the next steps.",
              style: TextStyle(
                  color: TColors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: Responsive.fontSize(context, 0.04)),
            ),
          ),
          const SizedBox(height: 25),
          FadeInSlide(
            duration: .6,
            child: Text(
              "Your Registered Email",
              style: TextStyle(
                  color: TColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: Responsive.fontSize(context, 0.04)),
            ),
          ),
          const SizedBox(height: 10),
          FadeInSlide(
            duration: .7,
            child: TextField(
              style: TextStyle(color: TColors.black),
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus!.unfocus(),
              // cursorColor: isDark ? Colors.grey : Colors.black54,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                filled: true,
                fillColor: isDark
                    ? TColors.dark.withOpacity(.1)
                    : TColors.light.withOpacity(.1),
                hintText: "Enter your email...",
                hintStyle: TextStyle(color: TColors.black.withOpacity(0.4)),
                prefixIcon: const Icon(IconlyLight.message, size: 20),
                prefixIconColor: isDark ? Colors.white : Colors.black87,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
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
              // Show loading dialog
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                      color: TColors.primary,
                      size: Responsive.width(context, 0.1),
                    ),
                  );
                },
              );

              // Simulate a delay
              await Future.delayed(Duration(seconds: 3));

              // Close the dialog
              Navigator.of(context).pop();

              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('OTP successfully sent'),
                  duration: Duration(seconds: 1),
                ),
              );

              // Navigate to OTPInputView
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => OTPInputView()),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: TColors.primary,
              fixedSize: const Size(double.infinity, 50),
            ),
            child: const Text(
              "Send OTP Code",
              style:
                  TextStyle(fontWeight: FontWeight.w900, color: TColors.white),
            ),
          ),
        ),
      ),
    );
  }
}
