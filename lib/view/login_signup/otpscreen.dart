import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qv_patient/view/homepage/home.dart';
import '../../model/globalvariable.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  
  get otpController => null;

  get verifyOTP => null;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF9643EA),
      body: Padding(
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
            Text(
              "Send OTP",
              style: GoogleFonts.poppins(
                  fontSize: height * 0.035,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffF8F7F7)),
            ),
            Text("Enter your OTP number send to ******0097",
                style: GoogleFonts.poppins(
                    fontSize: height * 0.015,
                    fontWeight: FontWeight.w500,
                    color: Color(0XFFFFFFFF)
                )
            ),
            TextField(
              cursorColor:Colors.white,
              style: TextStyle(color:CupertinoColors.white),
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter OTP',
                labelStyle: TextStyle(color:Colors.white)
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => Home()));
              },
              child: ElevatedButton(
                onPressed: verifyOTP,
                child: Text('Verify OTP',style: TextStyle(color: Colors.white)),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
