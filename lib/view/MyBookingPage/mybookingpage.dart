import 'package:flutter/material.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';
import 'package:qv_patient/constants/colors.dart';

import 'package:qv_patient/view/MyBookingPage/TabbarBookingInfo/canceled_page.dart';
import 'package:qv_patient/view/MyBookingPage/TabbarBookingInfo/completed_page.dart';
import 'package:qv_patient/view/MyBookingPage/TabbarBookingInfo/upcomming_page.dart';

class MyBookingPage extends StatelessWidget {
  const MyBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        backgroundColor: TColors.dark,
        body: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Spacer(),
                  FadeInSlide(
                    duration: 0.9,
                    direction: FadeSlideDirection.ltr,
                    child: Text(
                      "My Booking",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                          color: Colors.white),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(height: 20), // Add some spacing before the TabBar
            FadeInSlide(
              duration: 0.9,
              direction: FadeSlideDirection.ltr,
              child: TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                tabs: [
                  Tab(text: 'Upcoming'),
                  Tab(text: 'Completed'),
                  Tab(text: 'Cancelled'),
                ],
              ),
            ),
            Expanded(
              child: FadeInSlide(
                duration: 0.9,
                direction: FadeSlideDirection.ltr,
                child: TabBarView(
                  children: [
                    // Replace these with your actual content widgets
                    UpcommingTab(),
                    CompletedPage(),
                    CanceledPage(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
