import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/helper/responsive.dart';
import 'package:qv_patient/view/chatwithdoctor/message_with_doc_page.dart';
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

  final List<String> asseticonurl = [
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
        backgroundColor: TColors.primary,
        title: Text(
          'All Categories',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left, color: Colors.white),
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
                Navigator.push(context, CupertinoPageRoute(
                  builder: (context) {
                    return ChatScreen();
                  },
                ));
              },
              child: DepartmentContainer(
                  assetimgurl: asseticonurl[index],
                  departmentName: department[index]),
            );
          },
        ),
      ),
    );
  }
}
