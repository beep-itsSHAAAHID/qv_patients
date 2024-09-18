import 'package:cloud_firestore/cloud_firestore.dart';

class PatientModel {
  final String patientId;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String age;
  final String gender;
  final String profilePicUrl;
  final DocumentReference reference;

  PatientModel({
    required this.patientId,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.age,
    required this.gender,
    required this.profilePicUrl,
    required this.reference,
  });

  // Factory constructor to create a PatientModel instance from a Firestore document
  factory PatientModel.fromMap(Map<String, dynamic> data, DocumentReference reference) {
    return PatientModel(
      patientId: data['patientId'] ?? '',
      fullName: data['fullName'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      email: data['email'] ?? '',
      age: data['age'] ?? '',
      gender: data['gender'] ?? 'Not Specified',
      profilePicUrl: data['profilePicUrl'] ?? '',
      reference: reference,
    );
  }

  // Method to convert PatientModel to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'age': age,
      'gender': gender,
      'profilePicUrl': profilePicUrl,
    };
  }
}
