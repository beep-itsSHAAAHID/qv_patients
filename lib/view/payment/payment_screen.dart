import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/models/booking_model.dart';
import 'package:qv_patient/view/BookingConfirmationScreen/booking_confirmation_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentScreen extends StatefulWidget {
  final Booking booking;
  final double totalAmount;
  final double advanceAmount; // Add advance amount

  const PaymentScreen({
    Key? key,
    required this.booking,
    required this.totalAmount,
    required this.advanceAmount,
    required String qrData, // Accept advance amount
  }) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay _razorpay;
  double selectedAmount = 0.0; // To track the selected amount for payment

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _payWithRazorpay() {
    if (selectedAmount == 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an amount to pay.")),
      );
      return;
    }

    var options = {
      'key': 'whatsApp shahid', // Razorpay key
      'amount': (selectedAmount * 100).toInt(), // Amount in paise
      'name': widget.booking.doctorName,
      'description': 'Consultation Fee',
      'prefill': {
        'contact': widget.booking.patientPhoneNumber,
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    String transactionId = response.paymentId ?? "Unknown Transaction ID";

    // Generate booking ID and create a new booking
    String bookingId = await _generateBookingId();
    await _createBookingDocument(bookingId, transactionId);

    // Generate the QR data
    String qrData = '''
    Doctor ID: ${widget.booking.doctorId}
    Doctor Name: ${widget.booking.doctorName}
    Patient Name: ${widget.booking.patientName}
    Booking ID: $bookingId
    Token Number: ${widget.booking.appointmentDetails?['tokenNumber']}
    Date: ${widget.booking.bookingDate != null ? DateFormat('yyyy-MM-dd').format(widget.booking.bookingDate!) : 'Date not available'}
    Time: ${widget.booking.appointmentDetails?['timeSlot']}
    Transaction ID: $transactionId
    Consultation Fee: ₹${selectedAmount.toStringAsFixed(2)}
  ''';

    // Navigate to the booking confirmation screen and pass the QR data
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            BookingConfirmedScreen(qrData: qrData), // Pass QR data
      ),
    );
  }

  Future<String> _generateBookingId() async {
    DocumentReference idCounterRef = FirebaseFirestore.instance
        .collection('id_counters')
        .doc('booking_counter');
    DocumentSnapshot snapshot = await idCounterRef.get();

    if (snapshot.exists) {
      int counter = snapshot['counter'] ?? 0;
      String newBookingId =
          "QVB${(counter + 1).toString().padLeft(3, '0')}"; // Generate booking ID

      // Increment the counter
      await idCounterRef.update({'counter': counter + 1});

      return newBookingId;
    } else {
      throw Exception("Booking counter not found!");
    }
  }

  Future<void> _createBookingDocument(
      String bookingId, String transactionId) async {
    Map<String, dynamic> appointmentDetails = {
      'address': 'test',
      'phone': '1234567890',
      'timeSlot': 'Morning',
    };

    Map<String, dynamic> bookingData = {
      'appointmentDetails': appointmentDetails,
      'bookingDate': Timestamp.now(),
      'bookingId': bookingId,
      'bookingSource': 'online',
      'bookingType': 'fromOnline',
      'clinicId': widget.booking.clinicId,
      'doctorId': widget.booking.doctorId,

      'doctorName': widget.booking.doctorName,
      'patientId': widget.booking.patientId,
      'patientName': widget.booking.patientName,
      'paymentAmount': selectedAmount,
      'paymentStatus': 'confirmed',
      'status': 'upcoming',
      'tokenNumber':
          widget.booking.appointmentDetails?["tokenNumber"]?.toString() ?? "",
      'transactionId': transactionId, // Store the transaction ID
    };

    await FirebaseFirestore.instance
        .collection('bookings') // Ensure the collection name matches
        .doc(bookingId) // Use the bookingId as the document ID
        .set(bookingData);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Payment Failed! Please try again.")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("External Wallet selected.")),
    );
  }

  @override
  void dispose() {
    _razorpay.clear(); // Clear all listeners when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 252, 246),
      appBar: AppBar(
        title: const Text(
          "Payment Options",
          style: TextStyle(color: TColors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Total Amount: ₹${widget.totalAmount.toStringAsFixed(2)}",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: TColors.black),
            ),
            const SizedBox(height: 20),

            // Add SVG image below the total amount
            SvgPicture.asset(
              'assets/image/pay_money.svg', // Path to your SVG asset
              height: 150, // Adjust size as needed
            ),
            const SizedBox(height: 20),

            // Radio buttons to choose payment option
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: TColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                title: Text(
                  "Pay Advance Amount (₹${widget.advanceAmount.toStringAsFixed(2)})",
                  style: const TextStyle(color: TColors.black),
                ),
                leading: Radio<double>(
                  value: widget.advanceAmount,
                  groupValue: selectedAmount,
                  onChanged: (double? value) {
                    setState(() {
                      selectedAmount = value ?? 0.0;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: TColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                title: Text(
                  "Pay Complete Amount (₹${widget.totalAmount.toStringAsFixed(2)})",
                  style: const TextStyle(color: TColors.black),
                ),
                leading: Radio<double>(
                  value: widget.totalAmount,
                  groupValue: selectedAmount,
                  onChanged: (double? value) {
                    setState(() {
                      selectedAmount = value ?? 0.0;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Payment button
            ElevatedButton(
              onPressed: _payWithRazorpay,
              style: ElevatedButton.styleFrom(
                side: BorderSide.none,
                backgroundColor: TColors.primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Proceed to Payment"),
            ),
          ],
        ),
      ),
    );
  }
}
