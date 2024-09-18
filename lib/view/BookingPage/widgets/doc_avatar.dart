
import 'package:flutter/material.dart';

class DoctorAvatar extends StatelessWidget {
  const DoctorAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 30,
      backgroundImage: AssetImage('assets/image/doctor.jpg'),
    );
  }
}