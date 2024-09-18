 import 'package:flutter/material.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';

FadeInSlide buildOrDivider() {
    return const FadeInSlide(
      duration: .9,
      child: Row(
        children: [
          Expanded(
              child: Divider(
            thickness: .3,
          )),
          Text("   or   "),
          Expanded(
              child: Divider(
            thickness: .3,
          )),
        ],
      ),
    );
  }