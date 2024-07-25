import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/size.dart';
import 'package:qv_patient/helper/doc_helper_function.dart';
import 'package:qv_patient/helper/responsive.dart';
import 'package:qv_patient/view/homepage/widgets/t_primary_continer.dart';
import 'package:qv_patient/view/payment/payment_screen.dart';
import 'package:qv_patient/provider/user_provider.dart';
import 'package:qv_patient/provider/token_provider.dart';

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

    return Consumer(
      builder: (context, ref, child) {
        final userName = ref.watch(userProvider);

        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 252, 252, 246),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ListView(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                TPrimaryHeaderContainer(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const SizedBox(height: Tsizes.spcbtwsections),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                                const SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.doctor ?? '',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: TColors.dark,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      widget.specialty ?? '',
                                      style: const TextStyle(
                                        color: TColors.dark,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const Row(
                                      children: [
                                        Icon(
                                          Iconsax.location,
                                          color: TColors.dark,
                                          size: 15,
                                        ),
                                        Text(
                                          "Melattur,kerala",
                                          style: TextStyle(
                                            color: TColors.dark,
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
                      const SizedBox(height: Tsizes.defaultspace),
                      const Divider(indent: 20, endIndent: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DocReview(
                                  icons: Iconsax.people,
                                  titlenum: '7500+',
                                  title: 'Peoples'),
                              DocReview(
                                  icons: Iconsax.people,
                                  titlenum: '10+',
                                  title: 'Year Exp.'),
                              DocReview(
                                  icons: Iconsax.people,
                                  titlenum: '4.5+',
                                  title: 'Rating'),
                              DocReview(
                                  icons: Iconsax.people,
                                  titlenum: '4956+',
                                  title: 'Reviews'),
                            ]),
                      ),
                      SizedBox(height: Responsive.width(context, 0.1))
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          const Row(
                            children: [
                              Text(
                                'About',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: TColors.black),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                          Text(
                            'Add information about the doctor here...',
                            style:
                                TextStyle(fontSize: 14, color: TColors.black),
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
                                      color: TColors.black),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
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
                                            ? TColors.primary
                                            : TColors.primary.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            dayAbbreviation,
                                            style: const TextStyle(
                                              color: TColors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            '${currentDate.day}',
                                            style: const TextStyle(
                                              color: TColors.black,
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
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedSession = 'Morning';
                                  });
                                },
                                child: Text('Morning session',
                                    style: TextStyle(color: TColors.black)),
                                style: ButtonStyle(
                                  padding: WidgetStatePropertyAll(
                                      EdgeInsets.symmetric(horizontal: 20)),
                                  side: WidgetStatePropertyAll(BorderSide.none),
                                  backgroundColor: _selectedSession == 'Morning'
                                      ? WidgetStatePropertyAll(TColors.primary)
                                      : WidgetStatePropertyAll(
                                          TColors.primary.withOpacity(0.1)),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedSession = 'Evening';
                                  });
                                },
                                child: Text(
                                  'Evening session',
                                  style: TextStyle(color: TColors.black),
                                ),
                                style: ButtonStyle(
                                  padding: WidgetStatePropertyAll(
                                      EdgeInsets.symmetric(horizontal: 20)),
                                  side: WidgetStatePropertyAll(BorderSide.none),
                                  backgroundColor: _selectedSession == 'Evening'
                                      ? WidgetStatePropertyAll(TColors.primary)
                                      : WidgetStatePropertyAll(
                                          TColors.primary.withOpacity(0.1)),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 40),
                          GestureDetector(
                            onTap: () async {
                              if (_selectedDate != null &&
                                  _selectedSession != null &&
                                  widget.doctor != null) {
                                // Fetch the doctor's ID based on the name
                                String? doctorId =
                                    await fetchDoctorIdByName(widget.doctor!);

                                if (doctorId == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Doctor not found.")));
                                  return;
                                }

                                String patientName = userName ?? "Anonymous";
                                DateTime selectedDate = _selectedDate!;
                                String selectedSession = _selectedSession!;
                                String dateString =
                                    "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";

                                // Generate the next token number
                                int nextToken = await ref
                                    .read(tokenProvider.notifier)
                                    .generateTokenForBooking(doctorId,
                                        selectedSession, selectedDate);

                                // Proceed with navigation to the PaymentScreen
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => PaymentScreen(
                                      bookingData: {
                                        'doctorId': doctorId,
                                        'doctorName': widget.doctor,
                                        'patientName': patientName,
                                        'tokenNumber': nextToken.toString(),
                                        'session': selectedSession,
                                        'date': dateString,
                                      },
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "Please select a date, session, and ensure doctor's name is provided.")));
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 17),
                              decoration: BoxDecoration(
                                color: TColors.primary,
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(color: Colors.transparent),
                              ),
                              child: const Text(
                                'Book Appointment!',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: TColors.black),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
}

class DocReview extends StatelessWidget {
  const DocReview({
    super.key,
    required this.icons,
    required this.titlenum,
    required this.title,
  });

  final IconData icons;
  final String titlenum;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Responsive.width(context, 0.2),
          width: 70,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: TColors.black,
          ),
          margin: EdgeInsets.symmetric(horizontal: 0),
          child: Icon(
            icons,
            color: TColors.light,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          titlenum,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: TColors.black),
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .apply(color: TColors.darkGrey),
        ),
      ],
    );
  }
}

Future<String?> fetchDoctorIdByName(String doctorName) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('doctors')
        .where('doctorName', isEqualTo: doctorName)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first
          .id; // Assuming the first document found is the correct doctor
    }
    return null; // No doctor found
  } catch (e) {
    print("Error fetching doctor ID: $e");
    return null;
  }
}
