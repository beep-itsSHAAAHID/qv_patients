import 'package:cloud_firestore/cloud_firestore.dart';

class TokenController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<int> generateTokenForBooking(String doctorId, String session, DateTime selectedDate) async {
    String dateString = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";

    return firestore.runTransaction<int>((transaction) async {
      // Document reference for storing the last booking date and current token for each doctor and session
      DocumentReference doctorSessionRef = firestore.collection('doctor_sessions').doc('$doctorId-$session');

      // Try to read the current state of the doctor's session
      DocumentSnapshot doctorSessionSnapshot = await transaction.get(doctorSessionRef);

      int nextToken = 1; // Default to 1 if no bookings yet
      String lastBookingDate = dateString; // Default to today

      if (doctorSessionSnapshot.exists) {
        lastBookingDate = doctorSessionSnapshot.get('lastBookingDate');
        int lastToken = doctorSessionSnapshot.get('lastToken');

        if (lastBookingDate == dateString) {
          // If the booking is for today, increment the last token
          nextToken = lastToken + 1;
        }
      }

      // Update the session document with the new last booking date and token
      transaction.set(doctorSessionRef, {
        'lastBookingDate': dateString,
        'lastToken': nextToken,
      });

      return nextToken;
    }).catchError((error) {
      print("Failed to generate token: $error");
      return 0; // Handle the error or default case
    });
  }
}
