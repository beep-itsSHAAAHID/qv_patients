import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenNotifier extends StateNotifier<int> {
  TokenNotifier() : super(0);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<int> generateTokenForBooking(String doctorId, String session, DateTime selectedDate) async {
    String dateString = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";

    return firestore.runTransaction<int>((transaction) async {
      DocumentReference doctorSessionRef = firestore.collection('doctor_sessions').doc('$doctorId-$session');
      DocumentSnapshot doctorSessionSnapshot = await transaction.get(doctorSessionRef);

      int nextToken = 1; // Default to 1 if no bookings yet
      String lastBookingDate = dateString; // Default to today

      if (doctorSessionSnapshot.exists) {
        lastBookingDate = doctorSessionSnapshot.get('lastBookingDate');
        int lastToken = doctorSessionSnapshot.get('lastToken');

        if (lastBookingDate == dateString) {
          nextToken = lastToken + 1;
        }
      }

      transaction.set(doctorSessionRef, {
        'lastBookingDate': dateString,
        'lastToken': nextToken,
      });

      state = nextToken;
      return nextToken;
    }).catchError((error) {
      print("Failed to generate token: $error");
      return 0;
    });
  }
}

final tokenProvider = StateNotifierProvider<TokenNotifier, int>((ref) {
  return TokenNotifier();
});
