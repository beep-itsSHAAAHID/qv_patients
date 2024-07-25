import 'package:flutter/material.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/image_url.dart';
import 'package:qv_patient/view/NotificationPage/widgets/boxbutton.dart';
import 'package:qv_patient/view/NotificationPage/widgets/pageheading.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notificationData = [
      {
        'date': 'Today',
        'items': List.generate(20, (index) => 'Notification $index')
      },
      {
        'date': 'Yesterday',
        'items': List.generate(20, (index) => 'Notification $index')
      },
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 252, 252, 246),
        body: FadeInSlide(
          duration: 0.9,
          direction: FadeSlideDirection.ltr,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(),
                    SizedBox(
                      height: 40,
                      child: BoxButton(
                        labelText: "Mark as Read",
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: notificationData.length *
                      2, // Each section has a header and items
                  itemBuilder: (context, index) {
                    if (index.isOdd) {
                      // Odd index: Display items
                      final itemIndex = index ~/ 2;
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(TImages.user),
                        ),
                        title: Text(
                          notificationData[itemIndex]['items'][index],
                          style:
                              TextStyle(color: TColors.black.withOpacity(0.5)),
                        ),
                      );
                    } else {
                      // Even index: Display section header
                      final sectionIndex = index ~/ 2;
                      return ListTile(
                        title: Text(
                          notificationData[sectionIndex]['date'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: TColors.black),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
