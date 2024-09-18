import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/helper/responsive.dart';
import 'package:qv_patient/models/booking_model.dart';
import 'package:qv_patient/view/BookingPage/bookingpage.dart';
import 'package:qv_patient/view/BookingPage/widgets/total_cost_cal.dart';
import 'package:qv_patient/view/homepage/widgets/sectionheading.dart';
import 'package:qv_patient/view/homepage/widgets/t_primary_continer.dart';
import 'package:qv_patient/view/payment/payment_screen.dart';

class BookingDetailsScreen extends StatefulWidget {
  final Booking booking;

  const BookingDetailsScreen({Key? key, required this.booking})
      : super(key: key);

  @override
  _BookingDetailsScreenState createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  final TextEditingController _reasonController = TextEditingController();
  double platformFee = 11.8; // Sample platform fee with GST included

  double consultationFee = 0.0; // Initialize consultation fee
  double totalAmount = 0.0; // Initialize total amount

  Future<Map<String, dynamic>> _getDoctorDetails(String? doctorId) async {
    if (doctorId == null) {
      return {"name": "Doctor ID is missing", "consultationFee": 0.0};
    }

    try {
      // Access the clinic's subcollection `doctors` to get the doctor data
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('clinics')
          .doc(widget.booking.clinicId) // Get the specific clinic document
          .collection('doctors') // Access the `doctors` subcollection
          .doc(doctorId) // Get the specific doctor document
          .get();

      if (docSnapshot.exists) {
        // Extract the necessary fields from the doctor document
        String doctorName = docSnapshot['name'] ?? "Not available";
        String docid = docSnapshot['uid'] ?? "not available";

        // Safely converting consultationFees to double
        double consultationFee;
        if (docSnapshot['consultationFees'] is String) {
          consultationFee =
              double.tryParse(docSnapshot['consultationFees']) ?? 0.0;
        } else {
          consultationFee =
              (docSnapshot['consultationFees'] as num?)?.toDouble() ?? 0.0;
        }

        String about = docSnapshot['about'] ?? "Not available";
        String experience = docSnapshot['experience'] ?? "Not available";
        String specialization =
            docSnapshot['specialization'] ?? "Not available";

        // Update consultation fee and calculate the total amount
        setState(() {
          this.consultationFee = consultationFee;
          this.totalAmount = calculateTotalAmount(consultationFee, platformFee);
        });

        return {
          "docid": docid,
          "name": doctorName,
          "consultationFee": consultationFee,
          "about": about,
          "experience": experience,
          "specialization": specialization,
        };
      } else {
        return {
          "docid": "Doc id Not found",
          "name": "Doctor not found",
          "consultationFee": 0.0,
          "about": "Not available",
          "experience": "Not available",
          "specialization": "Not available"
        };
      }
    } catch (e) {
      print("Error fetching doctor details: $e");
      return {
        "docid": "Error fetching uid",
        "name": "Error fetching doctor name",
        "consultationFee": 0.0,
        "about": "Not available",
        "experience": "Not available",
        "specialization": "Not available"
      };
    }
  }

  // Function to calculate total amount
  double calculateTotalAmount(double consultationFee, double platformFee) {
    return consultationFee + platformFee;
  }
void _confirmBooking() {
  if (_reasonController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please provide a reason for the visit.")),
    );
    return;
  }

  // Generate the QR data here
  String qrData = '''
Doctor ID: ${widget.booking.doctorId}
Doctor Name: ${widget.booking.doctorName}
Patient Name: ${widget.booking.patientName}
Booking ID: ${widget.booking.bookingId}
Token Number: ${widget.booking.appointmentDetails?['tokenNumber']}
Date: ${widget.booking.bookingDate != null ? DateFormat('yyyy-MM-dd').format(widget.booking.bookingDate!) : 'Date not available'}
Time: ${widget.booking.appointmentDetails?['session']}
Reason: ${_reasonController.text}
Consultation Fee: ₹${consultationFee.toStringAsFixed(2)}
''';

  // Navigate to the PaymentScreen and pass the QR data
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => PaymentScreen(
        advanceAmount: platformFee,
        booking: widget.booking,
        totalAmount: totalAmount,
        qrData: qrData, // Pass the QR data here
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                side: BorderSide.none,
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: _confirmBooking,
              style: ElevatedButton.styleFrom(
                side: BorderSide.none,
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Continue"),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 252, 252, 246),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FutureBuilder<Map<String, dynamic>>(
                  future: _getDoctorDetails(widget.booking.doctorId),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                          child: Text("Error fetching doctor details"));
                    }

                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    String doctorName =
                        snapshot.data?['name'] ?? "Doctor not found";

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: Responsive.height(context, 0.2),
                            decoration: BoxDecoration(
                              color: TColors.dark.withOpacity(.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  const DoctorAvatar(),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.booking.doctorName!,
                                          style: TextStyle(
                                              color: TColors.dark,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 5),
                                        _buildBookingDetailRow("Patient: ",
                                            widget.booking.patientName ?? ""),
                                        _buildBookingDetailRow(
                                            "Token No: ",
                                            widget
                                                    .booking
                                                    .appointmentDetails?[
                                                        "tokenNumber"]
                                                    ?.toString() ??
                                                ""),
                                        _buildBookingDetailRow("Booking ID: ",
                                            widget.booking.bookingId ?? ""),
                                        _buildBookingDetailRow(
                                            "Date: ",
                                            widget.booking.bookingDate != null
                                                ? DateFormat('yyyy-MM-dd')
                                                    .format(widget
                                                        .booking.bookingDate!)
                                                : 'Date not available'),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  QrImageView(
                                    data: '''
Doctor ID: ${snapshot.data?['docid'] ?? "Unknown"}
Doctor Name: $doctorName
Patient Name: ${widget.booking.patientName}
Booking ID: ${widget.booking.bookingId}
Token Number: 123456
Date: ${widget.booking.bookingDate != null ? DateFormat('yyyy-MM-dd').format(widget.booking.bookingDate!) : 'Date not available'}
Time: ${widget.booking.appointmentDetails?['session']}
Reason: ${_reasonController.text}
Consultation Fee: ₹${consultationFee.toStringAsFixed(2)}
''',
                                    version: QrVersions.auto,
                                    size: 100,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                style: TextStyle(color: TColors.black),
                controller: _reasonController,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Enter Reason to vist...",
                  hintStyle: TextStyle(color: TColors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: TColors.primary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: TColors.black), // Same as unfocused
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: TColors.black), // Same as unfocused
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: TSectionHeading(
                title: "Booking Summary",
                textColor: Colors.black,
                showActionButton: false,
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: TotalCostCal(
                  consultationFee: consultationFee,
                  platformFee: platformFee,
                  totalAmount: totalAmount),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingDetailRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style:
              const TextStyle(color: TColors.dark, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: TColors.dark),
            overflow: TextOverflow.ellipsis, // Handle overflow gracefully
          ),
        ),
      ],
    );
  }
}

