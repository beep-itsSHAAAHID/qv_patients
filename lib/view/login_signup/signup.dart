import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qv_patient/view/login_signup/otpscreen.dart';

import '../../model/globalvariable.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _phoneno = TextEditingController();

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
                height: height * 0.02,
              ),
              // SvgPicture.asset("assets/image/authenticationimage.svg"),
              Text("Create Account Now",
                  style: GoogleFonts.jockeyOne(
                      fontSize: height * 0.04,
                      fontWeight: FontWeight.w400,
                      color: Color(0XFFFFFFFF))),

              SizedBox(
                height: height * 0.04,
              ),
              Text("Username",
                  style: GoogleFonts.inter(

                      fontSize: height * 0.018,
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
                        fontWeight: FontWeight.w500, fontSize: height * 0.02),
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
                height: height * 0.03,
              ),
              Text("Email",
                  style: GoogleFonts.inter(
                      fontSize: height * 0.018,
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
                        fontWeight: FontWeight.w500, fontSize: height * 0.02),
                    controller: _email,
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
                height: height * 0.03,
              ),
              Text("Password",
                  style: GoogleFonts.inter(
                      fontSize: height * 0.018,
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
                height: height * 0.03,
              ),
              Text("Phone Number",
                  style: GoogleFonts.inter(
                      fontSize: height * 0.018,
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
                        fontWeight: FontWeight.w500, fontSize: height * 0.02),
                    controller: _phoneno,
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
                height: height * 0.075,
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => OtpScreen()));
                },
                child: Container(
                  height: height * 0.07,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.5),
                      color: Color(0XFF33396B)),
                  child: Center(
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.inter(
                          fontSize: height * 0.022,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
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
