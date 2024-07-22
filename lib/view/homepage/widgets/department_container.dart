import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart'; // Ensure you have a package for icons
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/helper/responsive.dart';

class DepartmentContainer extends StatelessWidget {
  final String departmentName;

  const DepartmentContainer({
    super.key,
    required this.departmentName,
  });

  @override
  Widget build(BuildContext context) {
    // Define the icon based on the department name
    IconData departmentIcon;
    switch (departmentName) {
      case 'Neurologist':
        departmentIcon = Iconsax.next;
        break;
      case 'Dentist':
        departmentIcon = Iconsax.car1;
        break;
      case 'Cardiologist':
        departmentIcon = Iconsax.heart;
        break;
      case 'Psychiatrists':
        departmentIcon = Iconsax.emoji_happy;
        break;
      default:
        departmentIcon = Iconsax.user;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: Responsive.width(context, 0.02)),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.width(context, 0.03),
        vertical: Responsive.height(context, 0.01),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: Border.all(color: Colors.amber, width: 2), // Golden color border
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(departmentIcon, color: Colors.black, size: Responsive.width(context, 0.06)),
          const SizedBox(width: 8),
          Text(
            departmentName,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: Responsive.width(context, 0.04),
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
