import 'package:flutter/material.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/helper/responsive.dart';

import 'package:qv_patient/view/MyBookingPage/TabbarBookingInfo/canceled_page.dart';
import 'package:qv_patient/view/MyBookingPage/TabbarBookingInfo/completed_page.dart';
import 'package:qv_patient/view/MyBookingPage/TabbarBookingInfo/upcomming_page.dart';

class MyBookingPage extends StatelessWidget {
  const MyBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3, // Number of tabs
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 252, 252, 246),
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [TColors.dark.withOpacity(0.2), Colors.blue])),
                child: TabBar(
                  dividerColor: Colors.transparent,
                  labelColor: TColors.primary,
                  indicatorColor: TColors.primary,
                  unselectedLabelColor: TColors.black,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14.0,
                  ),
                  tabs: [
                    Tab(text: 'Upcoming'),
                    Tab(text: 'Completed'),
                    Tab(text: 'Cancelled'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // Replace these with your actual content widgets
                    UpcommingTab(),
                    CompletedPage(),
                    CanceledPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
