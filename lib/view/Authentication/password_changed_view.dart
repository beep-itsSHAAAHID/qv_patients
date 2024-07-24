import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/helper/responsive.dart';
import 'package:qv_patient/view/Authentication/get_started_view.dart';
import 'package:qv_patient/view/Authentication/login_view.dart';

class PasswordChangedView extends StatelessWidget {
  const PasswordChangedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 252, 246),
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FadeInSlide(
              duration: .4,
              child: Icon(
                IconlyBold.login,
                size: 60,
                color: TColors.black,
              )),
          SizedBox(height: 20),
          FadeInSlide(
            duration: .5,
            child: Text(
              "You're All Set!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: TColors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: Responsive.fontSize(context, 0.05)),
            ),
          ),
          SizedBox(height: 15),
          FadeInSlide(
            duration: .6,
            child: Text(
              "Your Password has been successfully changed",
              style: TextStyle(
                  color: TColors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: Responsive.fontSize(context, 0.03)),
              textAlign: TextAlign.center,
            ),
          ),
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
            onPressed: () {
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => const GetStartedView(),
                ),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: TColors.primary,
              fixedSize: const Size(double.infinity, 50),
            ),
            child: const Text(
              "Back To Login",
              style:
                  TextStyle(fontWeight: FontWeight.w900, color: TColors.white),
            ),
          ),
        ),
      ),
    );
  }
}
