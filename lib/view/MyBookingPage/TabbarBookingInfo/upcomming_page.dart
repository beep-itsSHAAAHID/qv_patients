import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qv_patient/view/MyBookingPage/BookingDetailPage/bookindetails_page.dart';
import 'package:qv_patient/view/MyBookingPage/widget/booking_card.dart';
import 'package:qv_patient/view/MyBookingPage/widget/my_button_withText.dart';

class UpcommingTab extends StatefulWidget {
  const UpcommingTab({super.key});

  @override
  State<UpcommingTab> createState() => _UpcommingTabState();
}

class _UpcommingTabState extends State<UpcommingTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: Column(
          children: [
            BookingCard(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => BookingDetailPage(
                        imageUrl: 'assets/image/doctor.jpg',
                        doctorName: "Dr. Smith",
                        appointmentDate: "Sep 10, 2024 - 2:00 PM",
                        location: "Downtown Clinic, Springfield",
                        bookingId: "#67890",
                      ),
                    ));
              },
              firstbuttontext: 'Cancel',
              secondbuttontext: 'Reschedule',
              imageurl: 'assets/image/doctor.jpg',
              doctorName: "Dr. Smith",
              appointmentDate: "Sep 10, 2024 - 2:00 PM",
              location: "Downtown Clinic, Springfield",
              bookingId: "#67890",
            ),
            BookingCard(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => BookingDetailPage(
                        imageUrl: 'assets/image/doctor.jpg',
                        doctorName: "Dr. Kunju",
                        appointmentDate: "Aug 5, 2024 - 5:00 PM",
                        location: "Perintalmanna",
                        bookingId: "#67890",
                      ),
                    ));
              },
              firstbuttontext: 'Cancel',
              secondbuttontext: 'Reschedule',
              imageurl: 'assets/image/doctor.jpg',
              doctorName: "Dr. Kunju",
              appointmentDate: "Aug 5, 2024 - 5:00 PM",
              location: "Perintalmanna",
              bookingId: "#67890",
            ),
            BookingCard(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => BookingDetailPage(
                        imageUrl: 'assets/image/doctor.jpg',
                        doctorName: "Dr. Kunju",
                        appointmentDate: "Aug 5, 2024 - 5:00 PM",
                        location: "Perintalmanna",
                        bookingId: "#67890",
                      ),
                    ));
              },
              firstbuttontext: 'Cancel',
              secondbuttontext: 'Reschedule',
              imageurl: 'assets/image/doctor.jpg',
              doctorName: "Dr. Kunju",
              appointmentDate: "Aug 5, 2024 - 5:00 PM",
              location: "Perintalmanna",
              bookingId: "#67890",
            )
          ],
        ),
      ),
    );
  }
}
