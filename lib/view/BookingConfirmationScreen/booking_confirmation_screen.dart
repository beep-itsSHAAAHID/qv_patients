import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qv_patient/navigationmenu.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart'; // For capturing QR code as an image
import 'package:gallery_saver/gallery_saver.dart'; // For saving the image
import 'package:path_provider/path_provider.dart'; // For accessing device directories
import 'dart:io'; // For file I/O

class BookingConfirmedScreen extends StatefulWidget {
  final String qrData;

  const BookingConfirmedScreen({Key? key, required this.qrData})
      : super(key: key);

  @override
  _BookingConfirmedScreenState createState() => _BookingConfirmedScreenState();
}

class _BookingConfirmedScreenState extends State<BookingConfirmedScreen>
    with TickerProviderStateMixin {
  bool showConfirmation = false;
  late final AudioPlayer _audioPlayer;
  final ScreenshotController _screenshotController =
      ScreenshotController(); // Controller for screenshot

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playSound() async {
    await _audioPlayer.play(AssetSource('sounds/success.mp3'));
  }

  Future<void> _vibratePhone() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 500);
    }
  }

  void _onLottieAnimationComplete() async {
    await _playSound();
    await _vibratePhone();
    setState(() {
      showConfirmation = true;
    });
  }

  Future<void> _saveQrToGallery() async {
    try {
      final Uint8List? capturedImage =
          await _screenshotController.capture(); // Capture the screenshot

      if (capturedImage != null) {
        // Save the image as a file in a temporary directory
        final directory = await getTemporaryDirectory();
        final String filePath = '${directory.path}/qr_code_booking.png';
        File imgFile = File(filePath);
        await imgFile.writeAsBytes(capturedImage);

        // Now save the image from the temporary file to the gallery
        final result = await GallerySaver.saveImage(filePath);

        if (result == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("QR code saved to gallery!")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to save QR code to gallery.")),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save QR code: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie animation that triggers the confirmation display once it ends
            Lottie.asset(
              'assets/lotties/transation_waiting.json',
              height: 300,
              repeat: false,
              onLoaded: (composition) {
                Future.delayed(
                  Duration(milliseconds: composition.duration.inMilliseconds),
                  _onLottieAnimationComplete,
                );
              },
            ),
            const SizedBox(height: 20),

            // Display confirmation text and QR code after animation completes
            if (showConfirmation) ...[
              const Text(
                'Booking Confirmed!',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: TColors.black),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your appointment is successfully booked.',
                style: TextStyle(fontSize: 16, color: TColors.black),
              ),
              const SizedBox(height: 20),

              // QR Code with Screenshot functionality
              Screenshot(
                controller: _screenshotController,
                child: QrImageView(
                  data: widget.qrData,
                  size: 150.0,
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Download button
              ElevatedButton(
                onPressed: _saveQrToGallery,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Save QR to Gallery"),
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                      builder: (context) {
                        return NavigationMenu();
                      },
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Go to Home"),
              )
            ],
          ],
        ),
      ),
    );
  }
}
