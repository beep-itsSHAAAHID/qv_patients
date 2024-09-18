  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';
import 'package:qv_patient/constants/colors.dart';

FadeInSlide buildSignUpButton( VoidCallback onpress) {
    return FadeInSlide(
      duration: 1,
      direction: FadeSlideDirection.btt,
      child: Container(
        padding:
            const EdgeInsets.only(bottom: 40, left: 20, right: 20, top: 30),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: .2, color: Colors.white),
          ),
        ),
        child: FilledButton(
          onPressed:onpress,
          style: FilledButton.styleFrom(
            backgroundColor: TColors.primary,
            fixedSize: const Size(double.infinity, 50),
          ),
          child: const Text(
            "Sign Up",
            style: TextStyle(fontWeight: FontWeight.w900, color: TColors.white),
          ),
        ),
      ),
    );
  }