import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';
import 'package:qv_patient/constants/loading_overlay.dart';
import 'package:qv_patient/view/Authentication/password_changed_view.dart';
import 'package:qv_patient/view/Authentication/widgets/widgets.dart';

class NewPasswordView extends StatelessWidget {
  const NewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: const [
          SizedBox(height: 20),
          FadeInSlide(
            duration: .4,
            child: Text(
              "Secure Your Account 🔒",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          SizedBox(height: 15),
          FadeInSlide(
            duration: .5,
            child: Text(
              'Almost there! Create a new password for your Smartome account to keep it secure. Remember to choose a strong and unique password.',
            ),
          ),
          SizedBox(height: 35),
          FadeInSlide(
            duration: .6,
            child: Text(
              "New Password",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 15),
          FadeInSlide(duration: .6, child: PasswordField()),
          SizedBox(height: 25),
          FadeInSlide(
            duration: .7,
            child: Text(
              "Confirm New Password",
              style: TextStyle(fontWeight: FontWeight.bold),
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
              LoadingScreen.instance()
                  .show(context: context, text: "Changing Password");
              await Future.delayed(const Duration(seconds: 1));
              for (var i = 0; i <= 100; i++) {
                LoadingScreen.instance().show(context: context, text: '$i...');
                await Future.delayed(const Duration(milliseconds: 10));
              }
              LoadingScreen.instance().show(
                  context: context, text: "Password Changed Successfully");
              await Future.delayed(const Duration(seconds: 1));
              LoadingScreen.instance().hide();
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const PasswordChangedView(),
                ),
              );
            },
            style: FilledButton.styleFrom(
              fixedSize: const Size(double.infinity, 50),
            ),
            child: const Text(
              "Save New Password",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ),
      ),
    );
  }
}
