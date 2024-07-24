import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/loading_overlay.dart';
import 'package:qv_patient/helper/responsive.dart';
import 'package:qv_patient/view/Authentication/password_changed_view.dart';
import 'package:qv_patient/view/Authentication/widgets/widgets.dart';

class NewPasswordView extends StatelessWidget {
  const NewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 252, 246),
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          FadeInSlide(
            duration: .4,
            child: Text("Secure Your Account 🔒",
                style: TextStyle(
                    color: TColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.fontSize(context, 0.06))),
          ),
          SizedBox(height: 15),
          FadeInSlide(
            duration: .5,
            child: Text(
                'Almost there! Create a new password for your Docbook account to keep it secure. Remember to choose a strong and unique password.',
                style: TextStyle(
                    color: TColors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: Responsive.fontSize(context, 0.04))),
          ),
          SizedBox(height: 35),
          FadeInSlide(
            duration: .6,
            child: Text(
              "New Password",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: TColors.black),
            ),
          ),
          SizedBox(height: 15),
          FadeInSlide(duration: .6, child: PasswordField()),
          SizedBox(height: 25),
          FadeInSlide(
            duration: .7,
            child: Text(
              "Confirm New Password",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: TColors.black),
            ),
          ),
          SizedBox(height: 15),
          FadeInSlide(duration: .7, child: PasswordField()),
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

              // Navigate to OTPInputView
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => PasswordChangedView()),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: TColors.primary,
              fixedSize: const Size(double.infinity, 50),
            ),
            child: const Text(
              "Save New Password",
              style:
                  TextStyle(fontWeight: FontWeight.w900, color: TColors.white),
            ),
          ),
        ),
      ),
    );
  }
}
