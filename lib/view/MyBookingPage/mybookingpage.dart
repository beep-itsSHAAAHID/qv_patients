import 'package:flutter/material.dart';
import 'package:qv_patient/view/MyBookingPage/TabbarBookingInfo/canceled_page.dart';
import 'package:qv_patient/view/MyBookingPage/TabbarBookingInfo/completed_page.dart';
import 'package:qv_patient/view/MyBookingPage/TabbarBookingInfo/upcomming_page.dart';
import 'package:qv_patient/view/MyBookingPage/widget/round_button_with_icon.dart';

class MyBookingPage extends StatelessWidget {
  const MyBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        backgroundColor: const Color(0XFF4682B4),
        body: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoundButton(
                    onPfressed: () => Navigator.of(context).pop(),
                    icon: Icons.arrow_back,
                    coloricon: Colors.black,
                  ),
                  const Text(
                    "My Booking",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30,color: Colors.white),
                  ),
                  RoundButton(
                    onPfressed: () {
                      // Handle search action
                    },
                    icon: Icons.search,
                    coloricon: Colors.black,
                  )
                ],
              ),
            ),
            const SizedBox(height: 20), // Add some spacing before the TabBar
            const TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              tabs: [
                Tab(text: 'Upcoming'),
                Tab(text: 'Completed'),
                Tab(text: 'Cancelled'),
              ],
            ),
            const Expanded(
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
    );
  }
}
