import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/globalvariable.dart';

class Pediatrician extends StatefulWidget {
  const Pediatrician({Key? key}) : super(key: key);

  @override
  State<Pediatrician> createState() => _PediatricianState();
}

class _PediatricianState extends State<Pediatrician> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF4682B4),

      appBar: AppBar(
        backgroundColor: Color(0XFF4682B4),
        title: Text(
          "Pediatricians",
          style: GoogleFonts.poppins(
            fontSize: height * 0.030,
            fontWeight: FontWeight.w600,
            color: Color(0XFFFFFFFF),
          ),
        ),centerTitle: true,
      ),
    );
  }
}
