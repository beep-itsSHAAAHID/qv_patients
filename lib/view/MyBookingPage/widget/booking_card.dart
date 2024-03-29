import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qv_patient/view/MyBookingPage/widget/my_button_withText.dart'; // Ensure this import path is correct

class BookingCard extends StatefulWidget {
  final String doctorName;
  final String appointmentDate;
  final String location;
  final String bookingId;
  final String imageurl;
  final String firstbuttontext;
  final String secondbuttontext;
  final bool? showSwitch;
  final VoidCallback? onTap;

  const BookingCard({
    super.key,
    required this.doctorName,
    required this.appointmentDate,
    required this.location,
    required this.bookingId,
    required this.imageurl,
    this.showSwitch = true,
    required this.firstbuttontext,
    required this.secondbuttontext,
    this.onTap,
  });

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  bool isReminder = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [BoxShadow(blurRadius: 2, spreadRadius: .1)],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget
                          .appointmentDate, // Correctly using provided appointmentDate
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (widget.showSwitch ?? true) ...[
                    const Text(
                      'Remind Me',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Switch(
                      activeColor: Colors.indigo,
                      value: isReminder,
                      onChanged: (value) {
                        setState(() {
                          isReminder = value;
                        });
                      },
                    ),
                  ],
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        widget
                            .imageurl, // Dynamically using provided image URL/path
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    // Wrapped in Expanded to prevent overflow
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget
                              .doctorName, // Dynamically using provided doctorName
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Iconsax.location,
                              size: 15,
                            ),
                            Text(widget.location),
                          ],
                        ), // Dynamically using provided location
                        Row(children: [
                          const Icon(
                            Iconsax.ticket,
                            size: 15,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Booking ID: ', // Dynamically using provided bookingId
                              ),
                              Text(
                                widget
                                    .bookingId, // Dynamically using provided bookingId
                                style: const TextStyle(
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ]),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyButtonWithText(
                    text: widget.firstbuttontext,
                    textColor: Colors.indigo,
                    backgroundColor: const Color.fromARGB(255, 179, 213, 241),
                  ),
                  MyButtonWithText(
                    text: widget.secondbuttontext,
                    textColor: Colors.white,
                    backgroundColor: Colors.indigo,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
