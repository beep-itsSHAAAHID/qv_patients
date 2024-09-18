import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchPatientDetails() async {
    final User? user = _auth.currentUser;
    final String? email = user?.email;

    if (email != null) {
      final querySnapshot = await _firestore
          .collection('patients')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first;
      } else {
        throw Exception("No patient found");
      }
    } else {
      throw Exception("No email found for the current user");
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchClinicName(String clinicId) async {
    final docSnapshot = await _firestore.collection('clinics').doc(clinicId).get();

    if (docSnapshot.exists) {
      return docSnapshot;
    } else {
      throw Exception("Clinic not found");
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchDoctorDetails(String clinicId, String doctorName) async {
    final querySnapshot = await _firestore
        .collection('clinics')
        .doc(clinicId)
        .collection('doctors')
        .where('name', isEqualTo: doctorName)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first;
    } else {
      throw Exception("Doctor not found");
    }
  }
}
