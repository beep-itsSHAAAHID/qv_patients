import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qv_patient/view/homepage/home.dart';
import 'package:qv_patient/view/onboarding/onboarding2.dart';
import 'package:qv_patient/view/login_signup/signup.dart';

import '../../model/globalvariable.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool value = false;

  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF4682B4),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
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
                height: height * 0.08,
              ),
              // SvgPicture.asset("assets/image/authenticationimage.svg"),
              Text("Welcome Back",
                  style: GoogleFonts.jockeyOne(
                      fontSize: height * 0.04,
                      fontWeight: FontWeight.w400,
                      color: Color(0XFFFFFFFF))),
              SizedBox(
                height: height * 0.01,
              ),
              Text("Login to continue",
                  style: GoogleFonts.inter(
                      fontSize: height * 0.018,
                      fontWeight: FontWeight.w400,
                      color: Color(0XFFFFFFFF))),
              SizedBox(
                height: height * 0.065,
              ),
              Text("Username",
                  style: GoogleFonts.inter(
                      fontSize: height * 0.022,
                      fontWeight: FontWeight.w900,
                      color: Color(0XFFFFFFFF))),

              SizedBox(
                height: height * 0.015,
              ),
              SizedBox(
                height: height * 0.07,
                width: width,
                child: TextFormField(
                    style: GoogleFonts.inter(
                      height: 1,
                        fontWeight: FontWeight.w500,
                        fontSize: height * 0.02),
                    controller: _username,
                    decoration: InputDecoration(
                      fillColor: Color(0xffFFFFFF),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            width * 0.07,
                          ),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.07),
                          borderSide: BorderSide.none),
                    )),
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Text("Password",
                  style: GoogleFonts.inter(
                      fontSize: height * 0.022,
                      fontWeight: FontWeight.w900,
                      color: Color(0XFFFFFFFF))),

              SizedBox(
                height: height * 0.015,
              ),
              SizedBox(
                height: height * 0.07,
                width: width,
                child: TextFormField(
                    style: GoogleFonts.inter(
                      height: 1,
                        fontWeight: FontWeight.w500, fontSize: height * 0.02),
                    controller: _password,
                    decoration: InputDecoration(
                      fillColor: Color(0xffFFFFFF),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            width * 0.07,
                          ),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.07),
                          borderSide: BorderSide.none),
                    )),
              ),
              SizedBox(
                height: height * 0.018,
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.blue,
                    side: BorderSide.none,
                    hoverColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                    fillColor: MaterialStatePropertyAll(Color(0xffD9D9D9)),
                    value: this.value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value!;
                      });
                    },
                  ),
                  Text("Remember me",
                      style: GoogleFonts.inter(
                          fontSize: height * 0.016,
                          fontWeight: FontWeight.w500,
                          color: Color(0XFFFFFFFF))),
                ],
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Forget password?",
                      style: GoogleFonts.inter(
                          fontSize: height * 0.016,
                          fontWeight: FontWeight.w500,
                          color: Color(0XFFFFFFFF))),
                ],
              ),
              SizedBox(
                height: height * 0.035,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => Home(),
                      ));
                },
                child: Container(
                  height: height * 0.07,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.5),
                      color: Color(0XFF33396B)),
                  child: Center(
                    child: Text(
                      "Login",
                      style: GoogleFonts.inter(
                          fontSize: height * 0.025,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.035,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => SignUpScreen(),
                      )
                  );
                },
                child: Center(
                  child: RichText(
                      text: TextSpan(
                          text: "Don't have an account?",
                          style: GoogleFonts.inter(
                              fontSize: height * 0.017,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffFFFFFF)),
                          children: [
                        TextSpan(
                            text: "Sign Up",
                            style: GoogleFonts.inter(
                                decoration: TextDecoration.underline,
                                fontSize: height * 0.017,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff000000)
                            )
                        )
                      ]
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
