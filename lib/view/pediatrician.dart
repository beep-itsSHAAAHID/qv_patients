import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';


class Pediatrician extends StatefulWidget {
  const Pediatrician({super.key});

  @override
  State<Pediatrician> createState() => _PediatricianState();
}

class _PediatricianState extends State<Pediatrician> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF4682B4),

      appBar: AppBar(
        backgroundColor: const Color(0XFF4682B4),
        title: Text(
          "Pediatricians",
          // style: GoogleFonts.poppins(
          //   fontSize: height * 0.030,
          //   fontWeight: FontWeight.w600,
          //   color: const Color(0XFFFFFFFF),
          // ),
        ),centerTitle: true,
      ),
    );
  }
}
