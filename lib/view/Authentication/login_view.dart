import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/loading_overlay.dart';
import 'package:qv_patient/view/Authentication/forgot_password_view.dart';
import 'package:qv_patient/view/Authentication/widgets/widgets.dart';
import 'package:qv_patient/view/homepage/home.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  ValueNotifier<bool> termsCheck = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;

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
            const FadeInSlide(duration: .6, child: EmailField()),
            const SizedBox(height: 20),
            const FadeInSlide(
              duration: .7,
              child: Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            const FadeInSlide(duration: .7, child: PasswordField()),
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
              LoadingScreen.instance()
                  .show(context: context, text: "Sign In...");
              await Future.delayed(const Duration(milliseconds: 500));
              for (var i = 0; i <= 100; i++) {
                LoadingScreen.instance().show(context: context, text: '$i...');
                await Future.delayed(const Duration(milliseconds: 5));
              }
              LoadingScreen.instance()
                  .show(context: context, text: "Signed In Successfully");
              await Future.delayed(const Duration(seconds: 1));
              LoadingScreen.instance().hide();
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => Home(),
                ),
              );
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
