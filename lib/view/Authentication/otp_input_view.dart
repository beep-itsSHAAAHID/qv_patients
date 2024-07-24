import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/helper/doc_helper_function.dart';
import 'package:qv_patient/helper/responsive.dart';
import 'package:qv_patient/view/Authentication/new_password_view.dart';

class OTPInputView extends StatelessWidget {
  const OTPInputView({super.key});

  @override
  Widget build(BuildContext context) {
    final count = ValueNotifier(6);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      count.value--;
      if (timer.tick == 6 || !context.mounted) {
        timer.cancel();
      }
    });

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 252, 246),
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          FadeInSlide(
            duration: .4,
            child: Text("Enter OTP Code 🔐",
                style: TextStyle(
                    color: TColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.fontSize(context, 0.06))),
          ),
          const SizedBox(height: 15),
          FadeInSlide(
            duration: .5,
            child: Text(
                "Please check your email inbox for a message from Smartome. Enter the one-time verification code below.",
                style: TextStyle(
                    color: TColors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: Responsive.fontSize(context, 0.04))),
          ),
          const SizedBox(height: 25),
          _buildPinPut(context),
          const SizedBox(height: 20),
          ValueListenableBuilder(
            valueListenable: count,
            builder: (context, value, child) {
              return Column(
                children: [
                  FadeInSlide(
                    duration: .7,
                    child: Text(
                      "You can resend the code in $value seconds",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 15),
                  FadeInSlide(
                    duration: .8,
                    child: TextButton(
                      onPressed: value > 0 ? null : () {},
                      child: const Text("Resend Code"),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPinPut(BuildContext context) {
    final dark = DocHelperFunctions.isDarkMode(context);
    final defaultPinTheme = PinTheme(
      width: 80,
      height: 70,
      textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: TColors.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      color: TColors.primary,
      border: Border.all(color: TColors.borderSecondary, width: 2),
      borderRadius: BorderRadius.circular(15),
    );

    // final submittedPinTheme = defaultPinTheme.copyWith(
    //   decoration: defaultPinTheme.decoration?.copyWith(
    //     color: const Color.fromRGBO(234, 239, 243, 1),
    //   ),
    // );

    return FadeInSlide(
      duration: .6,
      child: Pinput(
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        // submittedPinTheme: submittedPinTheme,
        validator: (s) {
          return s == '2222' ? null : 'Pin is incorrect';
        },
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        showCursor: true,
        autofocus: true,
        onCompleted: (pin) {
          print(pin);
          if (pin == '2222') {
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (context) => const NewPasswordView(),
              ),
            );
          }
        },
      ),
    );
  }
}
