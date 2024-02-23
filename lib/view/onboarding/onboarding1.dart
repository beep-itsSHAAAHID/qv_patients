import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qv_patient/view/login_signup/authentication_screen.dart';
import 'package:qv_patient/model/globalvariable.dart';
import 'package:qv_patient/view/onboarding/onboarding2.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
            color: Color(0XFF9643EA),
            image: DecorationImage(
                image: AssetImage("assets/image/illustration1.png"),
                fit: BoxFit.fill)),
        child: Padding(
          padding: EdgeInsets.only(
            left: width * 0.05,
            right: width * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.055,
              ),
              Text(
                "DOCBOOK",
                style: GoogleFonts.poppins(
                    fontSize: height * 0.023,
                    fontWeight: FontWeight.w600,
                    color: Color(0XFFED8446)),
              ),
              SizedBox(
                height: height * 0.3,
              ),
              Center(
                child: Text(
                  "START YOUR JOURNEY IN THE",
                  style: GoogleFonts.poppins(
                      fontSize: height * 0.025,
                      fontWeight: FontWeight.w600,
                      color: Color(0XFFFFFFFF)),
                ),
              ),
              Center(
                child: Text(
                  "FUTURE OF\n"
                  " HEALTH CARE",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: height * 0.035,
                      fontWeight: FontWeight.w800,
                      color: Color(0XFFFFFFFF)),
                ),
              ),
              SizedBox(
                height: height * 0.32,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const AuthenticationScreen(),
                      ));
                },
                child: Center(
                  child: Container(
                    height: height * 0.07,
                    width: width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.5),
                        color: Color(0XFF112950)),
                    child: Center(
                      child: Text(
                        "Let's Go",
                        style: GoogleFonts.poppins(
                            fontSize: height * 0.02,
                            fontWeight: FontWeight.w600,
                            color: Color(0XFFFFFFFF)),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
