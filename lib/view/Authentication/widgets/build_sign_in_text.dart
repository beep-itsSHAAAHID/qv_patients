  import 'package:flutter/cupertino.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';
import 'package:qv_patient/view/Authentication/login_view.dart';
import 'package:qv_patient/view/Authentication/widgets/widgets.dart';

FadeInSlide buildSignInText(BuildContext context) {
    return FadeInSlide(
      duration: .8,
      child: RichTwoPartsText(
        text1: "Already have an account? ",
        text2: "Sign In",
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const SignInView(),
            ),
          );
        },
      ),
    );
  }