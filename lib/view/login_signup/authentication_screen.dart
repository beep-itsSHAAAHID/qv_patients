import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qv_patient/view/login_signup/login.dart';
import 'package:qv_patient/view/login_signup/signup.dart';

import '../../model/globalvariable.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF4682B4),
      body: Padding(
        padding: EdgeInsets.only(
          left: width * 0.05,
          right: width * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.055,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("DOCBOOK",
                    style: GoogleFonts.jockeyOne(
                        fontSize: height * 0.04,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFFED8446))),
                // SvgPicture.asset(
                //   "assets/image/menu.svg",
                //   height: height * 0.045,
                // ),
              ],
            ),
            SizedBox(
              height: height * 0.38,
            ),

            Text("Hello,Welcome",
                style: GoogleFonts.jockeyOne(
                    fontSize: height * 0.04,
                    fontWeight: FontWeight.w300,
                    color: Color(0XFFFFFFFF))),
            SizedBox(
              height: height * 0.02,
            ),
            Text("Welcome To The Future Of HealthCare!",
                style: GoogleFonts.inter(
                    fontSize: height * 0.018,
                    fontWeight: FontWeight.w500,
                    color: Color(0XFFFFFFFF))),
            SizedBox(
              height: height * 0.03,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => Login(),
                    ));
              },
              child: Container(
                height: height * 0.07,
                width: width * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * 0.5),
                    color: Color(0XFF33396B)),
                child: Center(
                  child: Text(
                    "Login",
                    style: GoogleFonts.inter(
                        fontSize: height * 0.02,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => SignUpScreen(),
                    ));
              },
              child: Container(
                height: height * 0.07,
                width: width * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * 0.5),
                    color: Color(0XFF33396B)),
                child: Center(
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.inter(
                        fontSize: height * 0.02,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.055,
            ),
            // Text(
            //   "Or via social media",
            //   style: GoogleFonts.inter(
            //       fontSize: height * 0.018,
            //       fontWeight: FontWeight.w400,
            //       color: Color(0xffFFFFFF)),
            // ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/image/facebook.svg",
                  height: height * 0.03,
                ),
                SizedBox(
                  width: width * 0.04,
                ),
                SvgPicture.asset(
                  "assets/image/google.svg",
                  height: height * 0.03,
                ),
                SizedBox(
                  width: width * 0.04,
                ),
                SvgPicture.asset(
                  "assets/image/ln.svg",
                  height: height * 0.03,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
