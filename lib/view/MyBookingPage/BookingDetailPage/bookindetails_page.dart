import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/device/device_utility.dart';
import 'package:qv_patient/helper/responsive.dart';
import 'package:qv_patient/view/MyBookingPage/BookingDetailPage/widgets/rowwithtext.dart';

class BookingDetailPage extends StatelessWidget {
  final String doctorName;
  final String appointmentDate;
  final String location;
  final String bookingId;
  final String imageUrl;

  const BookingDetailPage({
    super.key,
    required this.doctorName,
    required this.appointmentDate,
    required this.location,
    required this.bookingId,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.primary,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "My booking",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: TColors.white,
                fontSize: 25),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 252, 252, 246),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Responsive.width(context, 0.03)),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Center(
                      child: Stack(children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(imageUrl),
                          radius: Responsive.width(context, 0.09),
                        ),
                        const Positioned(
                          bottom: 3,
                          right: -1,
                          child: Icon(
                            Iconsax.verify5,
                            color: Colors.blue,
                          ),
                        )
                      ]),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            doctorName,
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: TColors.black),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Iconsax.location,
                              size: 15,
                              color: Colors.blue,
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                location,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.grey),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(
                indent: 20,
                endIndent: 20,
                color: TColors.primary,
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Scheduled Appointment',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: TColors.black),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Date",
                        style: TextStyle(
                            fontSize: Responsive.width(context, 0.05),
                            color: TColors.black.withOpacity(0.5)),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        appointmentDate,
                        style: TextStyle(
                            fontSize: Responsive.width(context, 0.04),
                            fontWeight: FontWeight.bold,
                            color: TColors.black.withOpacity(0.5)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const RowWith2Text(
                firsttext: "Booking For",
                secondText: 'Self',
              ),
              const SizedBox(height: 20),
              const Divider(
                indent: 20,
                endIndent: 20,
                color: TColors.primary,
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Patient Info',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: TColors.black),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const RowWith2Text(firsttext: 'Full Name', secondText: "Abu"),
              const SizedBox(
                height: 10,
              ),
              const RowWith2Text(firsttext: 'Gender', secondText: "Male"),
              const SizedBox(
                height: 10,
              ),
              const RowWith2Text(firsttext: 'Age', secondText: "27"),
              const SizedBox(
                height: 10,
              ),
              const RowWith2Text(firsttext: 'Problem', secondText: "Fever"),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                indent: 20,
                endIndent: 20,
                color: TColors.primary,
              ),
              SizedBox(
                height: Responsive.height(context, 0.09),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: TColors.primary,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.all(12),
                      child: const Row(
                        children: [
                          Text(
                            'Current Token',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '01',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
