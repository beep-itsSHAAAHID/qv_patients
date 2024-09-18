
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qv_patient/repository/patient_repository.dart';
import '../models/patient_model.dart';

final patientControllerProvider =
    ChangeNotifierProvider<PatientController>((ref) {
  return PatientController(PatientRepository());
});

class PatientController extends ChangeNotifier {
  final PatientRepository _repository;

  PatientController(this._repository);

  Future<void> addPatient(
      BuildContext context, PatientModel patient) async {
    try {
      await _repository.addPatient(patient);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Patient added successfully!"),
          backgroundColor: Colors.green,
        ),
      );
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to add patient: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<PatientModel?> getPatient(BuildContext context, String patientId) async {
    try {
      return await _repository.getPatient(patientId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to fetch patient: $e"),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }
  }

  Future<void> updatePatient(BuildContext context, PatientModel patient) async {
    try {
      await _repository.updatePatient(patient);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Patient updated successfully!"),
          backgroundColor: Colors.green,
        ),
      );
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to update patient: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<List<PatientModel>> getAllPatients(BuildContext context) async {
    try {
      return await _repository.getAllPatients();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to fetch patients: $e"),
          backgroundColor: Colors.red,
        ),
      );
      return [];
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
