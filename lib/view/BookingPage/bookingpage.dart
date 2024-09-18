import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/size.dart';
import 'package:qv_patient/models/booking_model.dart';
import 'package:qv_patient/view/BookingPage/booking_details_page.dart';
import 'package:qv_patient/view/BookingPage/widgets/doc_review.dart';
import 'package:qv_patient/view/homepage/widgets/t_primary_continer.dart';

class BookingScreen extends StatefulWidget {
  final String? specialty;
  final String? doctor;
  final String? clinicId;
  final String? location;
  final String? docid;

  const BookingScreen(
    this.location,
    this.docid, {
    super.key,
    this.specialty,
    this.doctor,
    this.clinicId,
  });

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with SingleTickerProviderStateMixin {
  String? selectedDate;
  String? selectedSession;
  int? selectedTokenNumber;
  String? doctorId;
  String? patientName;
  String? patientGender;
  String? patientAge;
  String? patientEmail;
  String? patientPhoneNumber;
  String? patientProfilePicUrl;
  String? clinicName;

  String? doctorAbout;
  String? doctorConsultations;
  String? doctorExperience;

  String? patientId;
  final String bookingType = "fromOnline"; // Replace with actual booking type
  List<String> availableDays = [];
  Map<String, dynamic> sessionData = {};
  int tokenLimit = 0;

  // Animation controller
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _fetchPatientDetails();
    _fetchClinicName();
    _fetchDoctorData(widget.doctor.toString());

    // Initialize animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Set up the slide animation
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start from bottom of the screen
      end: Offset.zero, // End at the current position
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose of the animation controller
    super.dispose();
  }

  Future<void> _fetchPatientDetails() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final String? email = user?.email;

      if (email != null) {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('patients')
            .where('email', isEqualTo: email)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          final docSnapshot = querySnapshot.docs.first;

          setState(() {
            patientId = docSnapshot['patientId'];
            patientName = docSnapshot['fullName'];
            patientGender = docSnapshot['gender'];
            patientAge = docSnapshot['age'];
            patientEmail = docSnapshot['email'];
            patientPhoneNumber = docSnapshot['phoneNumber'];
            patientProfilePicUrl = docSnapshot['profilePicUrl'];
          });
        } else {
          setState(() {
            _setUnknownPatientDetails();
          });
        }
      } else {
        setState(() {
          _setUnknownPatientDetails();
        });
      }
    } catch (e) {
      setState(() {
        _setUnknownPatientDetails();
      });
    }
  }

  String getDayAbbreviation(String day) {
    switch (day) {
      case 'Monday':
        return 'Mon';
      case 'Tuesday':
        return 'Tue';
      case 'Wednesday':
        return 'Wed';
      case 'Thursday':
        return 'Thu';
      case 'Friday':
        return 'Fri';
      case 'Saturday':
        return 'Sat';
      case 'Sunday':
        return 'Sun';
      default:
        return '';
    }
  }

  void _setUnknownPatientDetails() {
    patientId = "Unknown ID";
    patientName = "Unknown Patient";
    patientGender = "Unknown Gender";
    patientAge = "Unknown Age";
    patientEmail = "Unknown Email";
    patientPhoneNumber = "Unknown Phone";
    patientProfilePicUrl = "https://example.com/default-profile-pic.png";
  }

  Future<void> _fetchClinicName() async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('clinics')
          .doc(widget.clinicId)
          .get();

      if (docSnapshot.exists) {
        setState(() {
          clinicName = docSnapshot['clinicName'];
        });
      } else {
        setState(() {
          clinicName = "Unknown Clinic";
        });
      }
    } catch (e) {
      setState(() {
        clinicName = "Error fetching clinic";
      });
    }
  }

  Future<void> _fetchDoctorData(String doctorName) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('clinics')
          .doc(widget.clinicId)
          .collection('doctors')
          .where('name', isEqualTo: doctorName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final docSnapshot = querySnapshot.docs.first;

        setState(() {
          doctorId = docSnapshot.id;
          doctorAbout = docSnapshot['about'] ?? 'No about info available';
          doctorConsultations = docSnapshot['consultations']?.toString() ?? '0';
          doctorExperience = docSnapshot['experience']?.toString() ?? '0';

          // Split availableDays into a list
          availableDays = docSnapshot['availableDays'].split(", ");
          sessionData = docSnapshot['sessions'];
        });
      } else {
        setState(() {
          doctorId = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text("Doctor not found. Please check the doctor's name.")),
        );
      }
    } catch (e) {
      print("Error fetching doctor details: $e");
    }
  }

  void handleBooking() async {
    if (_validateBooking()) {
      await _fetchDoctorData(widget.doctor!);

      if (doctorId != null && patientName != null) {
        final bookingId = DateTime.now().millisecondsSinceEpoch.toString();

        final Booking booking = Booking(
          doctorName: widget.doctor,
          patientPhoneNumber: patientPhoneNumber,
          bookingId: bookingId,
          doctorId: doctorId!,
          bookingDate: DateTime.parse(selectedDate!),
          patientName: patientName!,
          status: "pending",
          patientId: patientId,
          bookingType: bookingType,
          clinicId: widget.clinicId,
          appointmentDetails: {
            'session': selectedSession,
            'tokenNumber': selectedTokenNumber,
            'reason': 'Reason for visit here', // Placeholder for actual reason
            'gender': patientGender,
            'age': patientAge,
            'email': patientEmail,
            'phoneNumber': patientPhoneNumber,
            'profilePicUrl': patientProfilePicUrl,
            'clinicName': clinicName,
          },
          createdAt: DateTime.now(),
        );

        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => BookingDetailsScreen(booking: booking),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "Please select a date, session, and ensure doctor's name is provided.")));
    }
  }

  bool _validateBooking() {
    return selectedDate != null &&
        selectedSession != null &&
        selectedTokenNumber != null &&
        widget.doctor != null &&
        widget.doctor!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 252, 252, 246),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TPrimaryHeaderContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const SizedBox(height: Tsizes.spcbtwsections),
                    _buildDoctorInfoHeader(context),
                    const SizedBox(height: Tsizes.defaultspace),
                    const Divider(indent: 20, endIndent: 20),
                    _buildDoctorStatistics(),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // About Section
              _buildAboutsection(),
              const SizedBox(height: 20),

              // Date selection logic
              _buildDateSelection(),
              const SizedBox(height: 30),

              // Session selection logic
              _buildSessionSelection(),
              const SizedBox(height: 30),

              // Trigger animation when the session is selected and tokens are available
              if (selectedSession != null && tokenLimit > 0)
                _buildAnimatedTokenGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedTokenGrid() {
    // Start the animation
    _animationController.forward();

    return SlideTransition(
      position: _offsetAnimation, // Apply slide animation
      child: _buildTokenGrid(), // Your existing token grid
    );
  }

  Widget _buildTokenGrid() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(30),
        ),
        color: TColors.grey,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [TColors.grey, Colors.blue],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: GridView.builder(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(), // Disable scrolling in GridView
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, // Display 5 tokens per row
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.7, // Adjust to make tokens a bit smaller
              ),
              itemCount: tokenLimit,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTokenNumber = index + 1;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: selectedTokenNumber == index + 1
                          ? TColors.primary
                          : TColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}', // Display token number
                        style: const TextStyle(
                          color:
                              TColors.black, // Use a contrasting color for text
                          fontWeight: FontWeight.bold,
                          fontSize:
                              16, // Slightly bigger for better readability
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          _buildBookingButton(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDoctorInfoHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: TColors.dark.withOpacity(.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const DoctorAvatar(),
                  const SizedBox(width: 20),
                  DoctorInfo(
                    doctorName: widget.doctor,
                    specialty: widget.specialty,
                    location: widget.location,
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutsection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(title: 'About'),
          Text(
            doctorAbout ?? "About doctor here",
            style: const TextStyle(fontSize: 14, color: TColors.black),
          ),
          const SizedBox(height: 20),
          _SectionTitle(title: 'Appointment'),
        ],
      ),
    );
  }

  Widget _buildDoctorStatistics() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DocReview(
            icons: Icons.people,
            titlenum: doctorConsultations ?? '0',
            title: 'Consultations',
          ),
          DocReview(
            icons: Icons.business_center,
            titlenum: doctorExperience ?? '0',
            title: 'Year Exp.',
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          7,
          (index) {
            final currentDate = DateTime.now().add(Duration(days: index));
            final dayAbbreviation = getDayAbbreviation(
                DateFormat('EEEE').format(currentDate)); // Get day abbreviation
            final isSelected = selectedDate != null &&
                DateTime.parse(selectedDate!).day == currentDate.day &&
                DateTime.parse(selectedDate!).month == currentDate.month &&
                DateTime.parse(selectedDate!).year == currentDate.year;

            bool isAvailableDay = availableDays.contains(
                DateFormat('EEEE').format(currentDate)); // Check availability

            return InkWell(
              onTap: () {
                if (isAvailableDay) {
                  setState(() {
                    selectedDate = currentDate.toIso8601String();
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text("No booking available for the selected day"),
                    ),
                  );
                }
              },
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                decoration: BoxDecoration(
                  color: isSelected
                      ? TColors.primary
                      : isAvailableDay
                          ? TColors.primary.withOpacity(0.1)
                          : TColors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }

  Widget _buildSessionSelection() {
    return sessionData.isEmpty
        ? const Text("No sessions available")
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: sessionData.keys.map((sessionKey) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedSession = sessionKey;

                        // Parse token limit as an integer and re-render token selection
                        tokenLimit = int.tryParse(sessionData[sessionKey]
                                    ['tokenlimit']
                                .toString()) ??
                            0;
                        selectedTokenNumber = null; // Reset selected token
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      side: BorderSide.none,
                      backgroundColor: selectedSession == sessionKey
                          ? TColors.primary
                          : TColors.primary.withOpacity(0.1),
                    ),
                    child: Text(
                      '$sessionKey session',
                      style: const TextStyle(color: TColors.black),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
  }

  Widget _buildBookingButton() {
    return ElevatedButton(
      onPressed: handleBooking,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 17),
        backgroundColor: TColors.primary, // Background color of the button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22), // Rounded corners
        ),
      ),
      child: const Text(
        'Book Appointment!',
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: TColors.black),
      ),
    );
  }
}

// Additional Widgets
class DoctorAvatar extends StatelessWidget {
  const DoctorAvatar();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 40,
      backgroundImage: AssetImage('assets/image/doctor.jpg'),
    );
  }
}

class DoctorInfo extends StatelessWidget {
  final String? doctorName;
  final String? specialty;
  final String? location;

  const DoctorInfo({
    Key? key,
    this.doctorName,
    this.specialty,
    this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          doctorName ?? 'Unknown Doctor',
          style: const TextStyle(
            fontSize: 20,
            color: TColors.dark,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          specialty ?? 'Specialty Unknown',
          style: const TextStyle(
            color: TColors.dark,
            fontSize: 15,
          ),
        ),
        Row(
          children: [
            Icon(
              Icons.location_on,
              color: TColors.dark,
              size: 15,
            ),
            Text(
              location ?? 'Location Unknown',
              style: const TextStyle(
                color: TColors.dark,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: TColors.black),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
