// lib/repositories/patient_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/patient_model.dart';

class PatientRepository {
  final CollectionReference _patientsCollection =
      FirebaseFirestore.instance.collection('patients');

  Future<void> addPatient(PatientModel patient) async {
    try {
      await _patientsCollection.doc(patient.patientId).set(patient.toMap());
    } catch (e) {
      throw Exception('Failed to add patient: $e');
    }
  }

  Future<PatientModel?> getPatient(String patientId) async {
    try {
      DocumentSnapshot doc = await _patientsCollection.doc(patientId).get();
      if (doc.exists) {
        return PatientModel.fromMap(doc.data() as Map<String, dynamic>, doc.reference);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch patient: $e');
    }
  }

  Future<void> updatePatient(PatientModel patient) async {
    try {
      await _patientsCollection.doc(patient.patientId).update(patient.toMap());
    } catch (e) {
      throw Exception('Failed to update patient: $e');
    }
  }

  Future<List<PatientModel>> getAllPatients() async {
    try {
      QuerySnapshot querySnapshot = await _patientsCollection.get();
      return querySnapshot.docs
          .map((doc) => PatientModel.fromMap(doc.data() as Map<String, dynamic>, doc.reference))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch patients: $e');
    }
  }

   Future<String> generateNewPatientId() async {
    DocumentReference idCounterRef = FirebaseFirestore.instance
        .collection('id_counters')
        .doc('patientcounter');

    // Retrieve the current value of lastPatientId
    DocumentSnapshot snapshot = await idCounterRef.get();
    String lastPatientId = snapshot.get('lastPatientId') as String;

    // Extract the numeric part from the ID (assuming it's prefixed with "PI")
    int currentIdNumber =
        int.parse(lastPatientId.substring(2)); // Extract number after "PI"

    // Increment the numeric part
    int newIdNumber = currentIdNumber + 1;

    // Format the new ID as PI with leading zeros, e.g., PI002, PI010
    String newPatientId = 'PI${newIdNumber.toString().padLeft(3, '0')}';

    // Update the lastPatientId in Firestore
    await idCounterRef.update({'lastPatientId': newPatientId});

    return newPatientId;
  }
}
