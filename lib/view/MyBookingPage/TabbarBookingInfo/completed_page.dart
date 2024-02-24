import 'package:flutter/material.dart';
import 'package:qv_patient/view/MyBookingPage/widget/booking_card.dart';

class CompletedPage extends StatefulWidget {
  const CompletedPage({super.key});

  @override
  State<CompletedPage> createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: Column(
          children: [
            BookingCard(
              firstbuttontext: 'Re-Book',
              secondbuttontext: 'Review',
              showSwitch: false,
              imageurl: 'assets/image/doctor.jpg',
              doctorName: "Dr. Smith",
              appointmentDate: "Sep 10, 2024 - 2:00 PM",
              location: "Downtown Clinic, Springfield",
              bookingId: "#67890",
            ),
            BookingCard(
              firstbuttontext: 'Re-book',
              secondbuttontext: 'Review',
              showSwitch: false,
              imageurl: 'assets/image/doctor.jpg',
              doctorName: "Dr. Kunju",
              appointmentDate: "Aug 5, 2024 - 5:00 PM",
              location: "Perintalmanna",
              bookingId: "#67890",
            ),
            BookingCard(
              firstbuttontext: 'Re-book',
              secondbuttontext: 'Review',
              showSwitch: false,
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
