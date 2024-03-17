import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/image_url.dart';
import 'package:qv_patient/constants/size.dart';
import 'package:qv_patient/helper/doc_helper_function.dart';
import 'package:qv_patient/model/qrGenerator.dart';
import 'package:qv_patient/navigationmenu.dart';

class PaymentScreen extends StatefulWidget {
  final Map<String, dynamic> bookingData;
  const PaymentScreen({super.key, required this.bookingData});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final String doctorName;
  late final String patientName;
  late final String tokenNumber;
  late final String session;
  late final String date;

  int _selectedPaymentMethod =
      0; // 0 for Google Pay, 1 for PayPal, 2 for Visa, 3 for Master Card
  final _cardNumberController = TextEditingController();
  final _expirationDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _pinController = TextEditingController();
  bool _isProcessingPayment = false;

  @override
  void initState() {
    super.initState();
    doctorName = widget.bookingData['doctorName'] ?? '';
    patientName = widget.bookingData['patientName'] ?? '';
    tokenNumber = widget.bookingData['tokenNumber'] ?? '';
    session = widget.bookingData['session'] ?? '';
    date = widget.bookingData['date'] ?? '';
  }

  void dispose() {
    _cardNumberController.dispose();
    _expirationDateController.dispose();
    _cvvController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _processPayment() async {
    setState(() {
      _isProcessingPayment = true;
    });

    try {
      // Here, you would integrate with the payment gateway or service
      // to process the payment based on the selected payment method
      // and the entered payment details (if applicable).

      // Simulating a successful payment for demonstration purposes
      await Future.delayed(const Duration(seconds: 2));

      // Payment successful
      _showBookingConfirmation();
    } catch (e) {
      // Handle payment error
      _showErrorMessage(e.toString());
    }

    setState(() {
      _isProcessingPayment = false;
    });
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Payment successful'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showErrorMessage(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = DocHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Select Payment Method',
          ),
        ),
      ),
      body: Column(
        children: [
          // Container to show the amount
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: TColors.light.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount:',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    '\$300.00', // Replace with your actual amount
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7,
                      spreadRadius: 3,
                      color: TColors.light.withOpacity(0.1),
                    )
                  ],
                  color: TColors.light.withOpacity(0.1),
                  border: Border.all(
                    color: TColors.light.withOpacity(0.1),
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        RadioListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Google Pay',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .apply(color: TColors.grey),
                              ),
                              Image.asset(TImages.googlePay, height: 20),
                            ],
                          ),
                          value: 0, // Value for Google Pay
                          groupValue: _selectedPaymentMethod,
                          activeColor: Colors.green,
                          onChanged: (value) {
                            setState(() {
                              _selectedPaymentMethod = value as int;
                            });
                          },
                        ),
                        const SizedBox(
                          height: Tsizes.spcBtwitems,
                        ),
                        RadioListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pay Pal',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .apply(color: TColors.grey),
                              ),
                              Image.asset(TImages.paypal, height: 20),
                            ],
                          ),
                          value: 1, // Value for PayPal
                          activeColor: Colors.green,
                          groupValue: _selectedPaymentMethod,
                          onChanged: (value) {
                            setState(() {
                              _selectedPaymentMethod = value as int;
                            });
                          },
                        ),
                        const SizedBox(
                          height: Tsizes.spcBtwitems,
                        ),
                        RadioListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Visa',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .apply(color: TColors.grey),
                              ),
                              Image.asset(TImages.visa, height: 20),
                            ],
                          ),
                          value: 2, // Value for Visa
                          groupValue: _selectedPaymentMethod,
                          activeColor: Colors.green,
                          onChanged: (value) {
                            setState(() {
                              _selectedPaymentMethod = value as int;
                            });
                          },
                        ),
                        const SizedBox(
                          height: Tsizes.spcBtwitems,
                        ),
                        RadioListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Master Card',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .apply(color: TColors.grey),
                              ),
                              Image.asset(TImages.masterCard, height: 20),
                            ],
                          ),
                          value: 3, // Value for Master Card
                          groupValue: _selectedPaymentMethod,
                          activeColor: Colors.green,
                          onChanged: (value) {
                            setState(() {
                              _selectedPaymentMethod = value as int;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        if (_selectedPaymentMethod == 0 ||
                            _selectedPaymentMethod == 1)
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 70.0, left: 20, right: 20, bottom: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Enter PIN',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  controller: _pinController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: 'XXXX',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (_selectedPaymentMethod == 2 ||
                            _selectedPaymentMethod == 3)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Card Number',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                TextField(
                                  controller: _cardNumberController,
                                  decoration: const InputDecoration(
                                    hintText: 'XXXX XXXX XXXX XXXX',
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Expiration Date',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                TextField(
                                  controller: _expirationDateController,
                                  decoration: const InputDecoration(
                                    hintText: 'MM/YY',
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'CVV',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                TextField(
                                  controller: _cvvController,
                                  decoration: const InputDecoration(
                                    hintText: 'XXX',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed:
                                  _isProcessingPayment ? null : _processPayment,
                              child: _isProcessingPayment
                                  ? const CircularProgressIndicator(
                                      color: TColors.dark,
                                      backgroundColor: TColors.dark,
                                    )
                                  : const Text('Pay Now'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBookingConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: TColors.dark,
          title: const Center(child: Text("Booking Successful!")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Doctor's Name: $doctorName"),
              Text("Patient's Name: $patientName"), // Dynamic patient's name
              Text("Token Number: $tokenNumber"), // Dynamic token number
              Text("Session: $session"),
              Text(
                  "Date: ${date.isNotEmpty ? date.split(' ')[0] : ''}"), // Check if date is not empty
              const SizedBox(height: 10),
              SizedBox(
                width: 200,
                height: 200,
                child: TokenGenerationDataModel(
                  doctorName: doctorName,
                  tokenNumber: tokenNumber,
                  patientName: patientName,
                  appointmentTime: date,
                ).generateQrCodeWidget(),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacement(CupertinoPageRoute(builder: (ctx) {
                  return const NavigationMenu();
                }));
              },
              child: const Text(
                'OK',
                style: TextStyle(color: TColors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
