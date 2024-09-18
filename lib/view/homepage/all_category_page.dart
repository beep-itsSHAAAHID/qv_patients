import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/helper/responsive.dart';
import 'package:qv_patient/view/homepage/doctor_by_categorypage.dart';
import 'package:qv_patient/view/homepage/widgets/department_container.dart';

class AllCategoriesPage extends StatelessWidget {
  final List<String> department = [
    'Neurologist',
    'Dentist',
    'Cardiologist',
    'Psychiatrists',
    'Pediatrician',
    'Dermatologist',
    'Ophthalmology',
    'Gynecologist',
    'Orthopedic',
    'Radiologist',
    'Oncologist',
    'Anesthesiologist',
    'Gastroenterologist',
    'Nephrologist',
    'Urologist',
  ];

  final List<String> assetIconUrl = [
    'assets/icons/Neurologist.png',
    'assets/icons/Dentist.png',
    'assets/icons/Cardiologist.png',
    'assets/icons/Psychiatrists.png',
    'assets/icons/Pediatrician.png',
    'assets/icons/Dermatologist.png',
    'assets/icons/Ophthalmology.png',
    'assets/icons/Gynecologist.png',
    'assets/icons/Orthopedic.png',
    'assets/icons/Radiologist.png',
    'assets/icons/Oncologist.png',
    'assets/icons/Anesthesiologist.png',
    'assets/icons/Gastroenterologist.png',
    'assets/icons/Nephrologist.png',
    'assets/icons/Urologist.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 252, 246),
      appBar: AppBar(
        title: const Text(
          'All Categories',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: Responsive.symmetricPadding(context, 0.02, 0.05),
        child: GridView.builder(
          padding: EdgeInsets.all(Responsive.width(context, 0.02)),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: Responsive.width(context, 0.02),
            mainAxisSpacing: Responsive.height(context, 0.01),
          ),
          itemCount: department.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                // Navigate to the DoctorsByCategoryPage with the selected category
                Navigator.push(context, CupertinoPageRoute(
                  builder: (context) {
                    return DoctorsByCategoryPage(
                      category: department[index],
                    );
                  },
                ));
              },
              child: DepartmentContainer(
                assetimgurl: assetIconUrl[index],
                departmentName: department[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
