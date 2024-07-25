import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart'; // Ensure you have a package for icons
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/helper/responsive.dart';

class DepartmentContainer extends StatelessWidget {
  final String departmentName;
  final String assetimgurl;

  const DepartmentContainer({
    super.key,
    required this.departmentName,
    required this.assetimgurl,
  });

  @override
  Widget build(BuildContext context) {
    // Define the icon based on the department name
    IconData departmentIcon;
    switch (departmentName) {
      case 'Neurologist':
        departmentIcon = Iconsax.happyemoji;
        break;
      case 'Dentist':
        departmentIcon = Iconsax.tag;
        break;
      case 'Cardiologist':
        departmentIcon = Iconsax.heart;
        break;
      case 'Psychiatrist':
        departmentIcon = Iconsax.emoji_happy;
        break;
      case 'Pediatrician':
        departmentIcon = Iconsax.cake;
        break;
      case 'Dermatologist':
        departmentIcon = Iconsax.activity;
        break;
      case 'Ophthalmologist':
        departmentIcon = Iconsax.eye;
        break;
      // case 'Gynecologist':
      //   departmentIcon = Iconsax.woman;
      //   break;
      // case 'Orthopedic':
      //   departmentIcon = Iconsax.add;
      //   break;
      // case 'Radiologist':
      //   departmentIcon = Iconsax.radio;
      //   break;
      // case 'Oncologist':
      //   departmentIcon = Iconsax.airdrop;
      //   break;
      // case 'Anesthesiologist':
      //   departmentIcon = Iconsax.airplane2;
      //   break;
      // case 'ENT Specialist':
      //   departmentIcon = Iconsax.archive_slash2;
      //   break;
      // case 'Gastroenterologist':
      //   departmentIcon = Iconsax.arrow_left_3;
      //   break;
      // case 'Nephrologist':
      //   departmentIcon = Iconsax.award;
      //   break;
      // case 'Urologist':
      //   departmentIcon = Iconsax.bank5;
      // break;
      default:
        departmentIcon = Iconsax.user;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: Responsive.width(context, 0.07),
          backgroundColor: TColors.dark.withOpacity(0.04),
          child: Image(
            image: AssetImage(assetimgurl),
            width: Responsive.width(context, 0.09),
          ),
        ),
        Text(
          departmentName,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: Responsive.width(context, 0.03),
              color: TColors.black,
            ),
          ),
        ),
      ],
    );
  }
}

class DepartmentGrid extends StatelessWidget {
  final List<String> departments;
  final List<String> assetimgurl;

  const DepartmentGrid({
    super.key,
    required this.departments,
    required this.assetimgurl,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(Responsive.width(context, 0.02)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 4 items per line
        crossAxisSpacing: Responsive.width(context, 0.05),
        mainAxisSpacing: Responsive.height(context, 0.04),
      ),
      itemCount: departments.length,
      itemBuilder: (context, index) {
        return DepartmentContainer(
          departmentName: departments[index],
          assetimgurl: assetimgurl[index],
        );
      },
    );
  }
}
