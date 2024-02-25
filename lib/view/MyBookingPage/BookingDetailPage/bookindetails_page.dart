import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qv_patient/view/MyBookingPage/BookingDetailPage/widgets/rowwithtext.dart';
import 'package:qv_patient/view/MyBookingPage/widget/round_button_with_icon.dart';

class BookingDetailPage extends StatelessWidget {
  final String doctorName;
  final String appointmentDate;
  final String location;
  final String bookingId;
  final String imageUrl;

  const BookingDetailPage({
    Key? key,
    required this.doctorName,
    required this.appointmentDate,
    required this.location,
    required this.bookingId,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundButton(
                  icon: Icons.arrow_back,
                  onPfressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Spacer(),
                const Text(
                  "My Appointment",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                      color: Colors.black),
                ),
                Spacer(),
              ],
            ),
            SizedBox(
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
                        radius: 50,
                      ),
                      Positioned(
                        bottom: 8,
                        right: -1,
                        child: Icon(
                          Iconsax.verify5,
                          color: Colors.blue,
                        ),
                      )
                    ]),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctorName,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(
                            Iconsax.location,
                            size: 15,
                            color: Colors.blue,
                          ),
                          Text(
                            location,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    'Scheduled Appointment',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Date",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  Text(
                    appointmentDate,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            RowWith2Text(
              firsttext: "Booking For",
              secondText: 'Self',
            ),
            SizedBox(height: 20),
            Divider(
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    'Patient Info',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RowWith2Text(firsttext: 'Full Name', secondText: "Abu"),
            SizedBox(
              height: 10,
            ),
            RowWith2Text(firsttext: 'Gender', secondText: "Male"),
            SizedBox(
              height: 10,
            ),
            RowWith2Text(firsttext: 'Age', secondText: "27"),
            SizedBox(
              height: 10,
            ),
            RowWith2Text(firsttext: 'Problem', secondText: "Fever"),
            SizedBox(
              height: 20,
            ),
            Divider(
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blue[100],
                          child: Icon(Iconsax.message),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Messaging',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 100,
                                ),
                                Text(
                                  '\$20',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  textAlign: TextAlign.start,
                                  'Chat with Doctor',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 100,
                                ),
                                Text(
                                  'paid',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(Colors.white),
                backgroundColor: MaterialStatePropertyAll(Colors.indigo)),
            onPressed: () {},
            child: Text(
              'Message (Start at 16:00 PM)',
              style: TextStyle(fontSize: 25),
            )),
      ),
    );
  }
}
