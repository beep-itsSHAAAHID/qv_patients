
  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';
import 'package:qv_patient/view/Authentication/widgets/widgets.dart';

FadeInSlide buildSocialButtons(bool isDark) {
    return FadeInSlide(
      duration: 1.0,
      child: Column(
        children: [
          LoginButton(
            icon: Brand(Brands.google, size: 25),
            text: "Continue with Google",
            onPressed: () {},
          ),
          const SizedBox(height: 20),
          LoginButton(
            icon: Icon(
              Icons.apple,
              color: isDark ? Colors.white : Colors.black,
            ),
            text: "Continue with Apple",
            onPressed: () {},
          ),
        ],
      ),
    );
  }