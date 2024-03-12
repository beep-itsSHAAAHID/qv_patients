import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/size.dart';
import 'package:qv_patient/helper/doc_helper_function.dart';
import 'package:qv_patient/view/homepage/widgets/t_primary_continer.dart';

import '../../model/qrGenerator.dart';

class BookingScreen extends StatefulWidget {
  final String? specialty;
  final String? doctor;

  const BookingScreen({super.key, this.specialty, this.doctor});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String? _selectedSession;
  DateTime? _selectedDate;
  List<IconData> icons = [
    Iconsax.people,
    Iconsax.briefcase,
    Iconsax.star,
    Iconsax.message,
  ];
  List<dynamic> titlenum = ['7500+', "10+", "4.5+", "4956+"];
  List<dynamic> title = ['patients', "Year Exp.", "Rating", "Reviews"];
  @override
  Widget build(BuildContext context) {
    final dark = DocHelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.dark : TColors.dark.withOpacity(.9),
      body: Column(
        children: [
          TPrimaryHeaderContainer(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                FadeInSlide(
                  duration: 0.9,
                  direction: FadeSlideDirection.ltr,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: TColors.white,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Book Appointment',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .apply(color: TColors.white),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: Tsizes.spcbtwsections,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: FadeInSlide(
                    duration: 0.9,
                    direction: FadeSlideDirection.ltr,
                    child: Container(
                      decoration: BoxDecoration(
                        color: TColors.dark.withOpacity(.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            const Stack(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage:
                                      AssetImage('assets/image/doctor.jpg'),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 10,
                                  child: Icon(
                                    Icons.verified,
                                    color: Colors.blueAccent,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.doctor ?? '',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: TColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.specialty ?? '',
                                  style: const TextStyle(
                                    color: TColors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                const Row(
                                  children: [
                                    Icon(
                                      Iconsax.location,
                                      color: TColors.white,
                                      size: 15,
                                    ),
                                    Text(
                                      "Melattur,kerala",
                                      style: TextStyle(
                                        color: TColors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: Tsizes.defaultspace,
                ),
                const Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                Row(
                  children: List.generate(
                    4,
                    (index) => FadeInSlide(
                      duration: 0.9,
                      direction: FadeSlideDirection.ltr,
                      child: Column(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: TColors.black,
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: Icon(
                              icons[index],
                              color: TColors.light,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            titlenum[index],
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .apply(color: TColors.black),
                          ),
                          Text(
                            title[index],
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .apply(color: TColors.darkGrey),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        FadeInSlide(
                          duration: 0.9,
                          direction: FadeSlideDirection.ltr,
                          child: Text(
                            'About',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    const FadeInSlide(
                      duration: 0.9,
                      direction: FadeSlideDirection.ltr,
                      child: Text(
                        'Add information about the doctor here...',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        FadeInSlide(
                          duration: 0.9,
                          direction: FadeSlideDirection.ltr,
                          child: Text(
                            'Appointment',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: FadeInSlide(
                        duration: 0.9,
                        direction: FadeSlideDirection.ltr,
                        child: Row(
                          children: List.generate(
                            7,
                            (index) {
                              final currentDate =
                                  DateTime.now().add(Duration(days: index));
                              final dayAbbreviation =
                                  _getDayAbbreviation(currentDate.weekday);
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedDate = currentDate;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 25),
                                  decoration: BoxDecoration(
                                    color: _selectedDate != null &&
                                            currentDate.day ==
                                                _selectedDate!.day
                                        ? TColors.light
                                        : TColors.light.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        dayAbbreviation,
                                        style: const TextStyle(
                                          color: TColors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '${currentDate.day}',
                                        style: const TextStyle(
                                          color: TColors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: FadeInSlide(
                        duration: 0.9,
                        direction: FadeSlideDirection.ltr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedSession = 'Morning';
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10),
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: _selectedSession == 'Morning'
                                      ? TColors.light
                                      : TColors.light.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(22),
                                  border: Border.all(color: Colors.transparent),
                                ),
                                child: const Text(
                                  'Morning Session',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedSession = 'Evening';
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10),
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: _selectedSession == 'Evening'
                                      ? TColors.light
                                      : TColors.light.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(22),
                                  border: Border.all(color: Colors.transparent),
                                ),
                                child: const Text(
                                  'Evening Session',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        _showBookingConfirmation();
                      },
                      child: FadeInSlide(
                        duration: 0.9,
                        direction: FadeSlideDirection.ltr,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 17),
                          decoration: BoxDecoration(
                            color: TColors.light,
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(color: Colors.transparent),
                          ),
                          child: const Text(
                            'Book Appointment!',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getDayAbbreviation(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }

  void _showBookingConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: TColors.light,
          title: const Text("Booking Successful!"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Doctor's Name: ${widget.doctor}"),
              const Text(
                  "Patient's Name: Sajjad"), // Replace [Your Patient's Name] with actual patient's name
              const Text(
                  "Token Number: 10"), // Replace [Token Number] with actual token number
              Text("Session: $_selectedSession"),
              Text(
                  "Date: ${_selectedDate != null ? _selectedDate!.toLocal().toString().split(' ')[0] : ''}"),
              const SizedBox(height: 10),
              SizedBox(
                width: 200,
                height: 200,
                child: TokenGenerationDataModel(
                  doctorName: '${widget.doctor}',
                  tokenNumber: '10',
                  patientName: 'Sajjad',
                  appointmentTime: '$_selectedSession"',
                ).generateQrCodeWidget(),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
