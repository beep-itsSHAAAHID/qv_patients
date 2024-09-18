import 'package:cloud_firestore/cloud_firestore.dart';

class Clinic {
  final String role;
  final String clinicId;
  final String clinicName;
  final GeoPoint location;
  final Map<String, dynamic> contact;
  final List<Map<String, dynamic>> staff; // List of Maps to represent doctors
  final List<dynamic> bookings;
  final int revenue;
  final String profilePhoto;
  final String backgroundPhoto;
  final Map<String, dynamic> operatingHours;
  final String reference;
  final int status;
  final DateTime expiryDate;
  final List<dynamic> availableTreatments;

  Clinic({
    required this.role,
    required this.clinicId,
    required this.clinicName,
    required this.location,
    required this.contact,
    required this.staff,
    required this.bookings,
    required this.revenue,
    required this.profilePhoto,
    required this.backgroundPhoto,
    required this.operatingHours,
    required this.reference,
    required this.status,
    required this.expiryDate,
    required this.availableTreatments,
  });

  // Factory constructor to create a Clinic instance from a DocumentSnapshot
  factory Clinic.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Clinic(
      role: data['role'] ?? 'superAdmin',
      clinicId: data['clinicId'] ?? '',
      clinicName: data['clinicName'] ?? '',
      location: data['location'] ?? GeoPoint(0, 0),
      contact: data['contact'] ?? {},
      staff: List<Map<String, dynamic>>.from(data['staff'] ?? []),
      bookings: List<dynamic>.from(data['bookings'] ?? []),
      revenue: data['revenue'] ?? 0,
      profilePhoto: data['profilePhoto'] ?? '',
      backgroundPhoto: data['backgroundPhoto'] ?? '',
      operatingHours: Map<String, dynamic>.from(data['operatingHours'] ?? {}),
      reference: data['reference'] ?? '',
      status: data['status'] ?? 0,
      expiryDate: (data['expiryDate'] as Timestamp).toDate(),
      availableTreatments: List<dynamic>.from(data['availableTreatments'] ?? []),
    );
  }

  // Method to list all doctors
  List<Map<String, dynamic>> listAllDoctors() {
    return staff;
  }
}
