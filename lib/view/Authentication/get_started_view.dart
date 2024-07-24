import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/helper/doc_helper_function.dart';
import 'package:qv_patient/helper/responsive.dart';
import 'package:qv_patient/view/Authentication/login_view.dart';
import 'package:qv_patient/view/Authentication/create_account_view.dart';
import 'package:qv_patient/view/Authentication/widgets/widgets.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class GetStartedView extends StatelessWidget {
  const GetStartedView({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = DocHelperFunctions.isDarkMode(context);
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    final height = size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 252, 246),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            FadeInSlide(
              duration: .4,
              child: Icon(
                Icons.dashboard_rounded,
                size: Responsive.width(context, 0.2),
                color: TColors.primary,
              ),
            ),
            const Spacer(),
            FadeInSlide(
              duration: .5,
              child: Text(
                "Let's Get Started!",
                style: TextStyle(
                    color: TColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.fontSize(context, 0.06)),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: height * 0.015),
            FadeInSlide(
              duration: .6,
              child: Text("Let's dive in into your account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: TColors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: Responsive.fontSize(context, 0.03))),
            ),
            const Spacer(),
            FadeInSlide(
              duration: .7,
              child: LoginButton(
                icon:
                    Brand(Brands.google, size: Responsive.width(context, 0.05)),
                text: "Continue with Google",
                onPressed: () {},
              ),
            ),
            SizedBox(height: height * 0.02),
            FadeInSlide(
              duration: .8,
              child: LoginButton(
                icon: Brand(Brands.facebook,
                    size: Responsive.width(context, 0.05)),
                text: "Continue with Facebook",
                onPressed: () {},
              ),
            ),
            SizedBox(height: height * 0.02),
            const Spacer(),
            FadeInSlide(
              duration: 1.1,
              child: FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const SignInView(),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  alignment: Alignment.center,
                  backgroundColor: TColors.primary,
                  fixedSize: const Size.fromHeight(50),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: TColors.textWhite,
                      fontSize: Responsive.fontSize(context, 0.03)),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            FadeInSlide(
              duration: 1.2,
              child: FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const SignUpView(),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  fixedSize: const Size.fromHeight(50),
                  backgroundColor: TColors.black,
                ),
                child: Text("Create Account",
                    style: TextStyle(
                        color: TColors.textWhite,
                        fontSize: Responsive.fontSize(
                          context,
                          0.03,
                        ))),
              ),
            ),
            const Spacer(),
            FadeInSlide(
              duration: 1.0,
              direction: FadeSlideDirection.btt,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Powered by",
                    style: TextStyle(
                        color: TColors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: Responsive.width(context, 0.01),
                  ),
                  Image(
                    image: AssetImage(
                      'assets/text/qvtext.png',
                    ),
                    width: Responsive.width(context, 0.28),
                  )
                ],
              ),
            ),
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }
}
