import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String? bookingId; // Firestore document ID
  final String? clinicId; // Reference to the clinic document
  final String? patientId; // Reference to the patient document
  final String? bookingType; // "offline" or "online"
  final DateTime? bookingDate; // Date of the booking
  final String? patientName; // Name of the patient
  final String? doctorId; // ID of the doctor
  final String? doctorName; // Name of the doctor (Newly added)
  final String? status; // Status of the booking (e.g., confirmed, canceled)
  final Map<String, dynamic>?
      appointmentDetails; // Additional appointment details
  final DateTime? createdAt; // When the booking was created
  final int? tokenNumber; // Token number for the appointment
  final String? paymentStatus; // Payment status (e.g., paid, pending)
  final double? paymentAmount; // Payment amount for the appointment
  final String? paymentMethod; // Payment method (e.g., credit card, cash)
  final String? transactionId; // Transaction ID for online payments
  final String? bookingSource; // Source of booking (e.g., "app", "walk-in")
  final String? appointmentLocation; // Location details for offline bookings
  final bool? isFirstVisit; // Indicates if this is the patient's first visit
  final DocumentReference?
      relatedDocumentReference; // Reference to another related document
  final String? patientPhoneNumber; // Patient's phone number

  Booking({
    this.bookingId,
    this.clinicId,
    this.patientId,
    this.bookingType,
    this.bookingDate,
    this.patientName,
    this.doctorId,
    this.doctorName, // Added doctorName field
    this.status,
    this.appointmentDetails,
    this.createdAt,
    this.tokenNumber,
    this.paymentStatus,
    this.paymentAmount,
    this.paymentMethod,
    this.transactionId,
    this.bookingSource,
    this.appointmentLocation,
    this.isFirstVisit,
    this.relatedDocumentReference,
    this.patientPhoneNumber,
  });

  // Factory constructor to create a Booking instance from Firestore data
  factory Booking.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Booking(
      bookingId: doc.id,
      clinicId: (data['clinicId'] as DocumentReference?)
          ?.id, // Extract the clinicId from the reference
      patientId: (data['patientId'] as DocumentReference?)
          ?.id, // Extract the patientId from the reference
      bookingType: data['bookingType'] ?? '',
      bookingDate: (data['bookingDate'] as Timestamp?)?.toDate(),
      patientName: data['patientName'] ?? '',
      doctorId: data['doctorId'] ?? '',
      doctorName: data['doctorName'] ?? '', // Added doctorName field
      status: data['status'] ?? '',
      appointmentDetails: data['appointmentDetails'] ?? {},
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      tokenNumber: data['tokenNumber'] ?? 0,
      paymentStatus: data['paymentStatus'] ?? 'pending',
      paymentAmount: (data['paymentAmount'] as num?)?.toDouble() ?? 0.0,
      paymentMethod: data['paymentMethod'],
      transactionId: data['transactionId'],
      bookingSource: data['bookingSource'],
      appointmentLocation: data['appointmentLocation'],
      isFirstVisit: data['isFirstVisit'] ?? false,
      relatedDocumentReference: data[
          'relatedDocumentReference'], // Retrieve the related document reference
      patientPhoneNumber: data['patientPhoneNumber'] ?? '',
    );
  }

  // Method to convert a Booking instance to a Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'clinicId': clinicId != null
          ? FirebaseFirestore.instance.collection('clinics').doc(clinicId)
          : null,
      'patientId': patientId != null
          ? FirebaseFirestore.instance.collection('patients').doc(patientId)
          : null,
      'bookingType': bookingType,
      'bookingDate':
          bookingDate != null ? Timestamp.fromDate(bookingDate!) : null,
      'patientName': patientName,
      'doctorId': doctorId,
      'doctorName': doctorName, // Added doctorName field to the map
      'status': status,
      'appointmentDetails': appointmentDetails,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'tokenNumber': tokenNumber,
      'paymentStatus': paymentStatus,
      'paymentAmount': paymentAmount,
      'paymentMethod': paymentMethod,
      'transactionId': transactionId,
      'bookingSource': bookingSource,
      'appointmentLocation': appointmentLocation,
      'isFirstVisit': isFirstVisit,
      'relatedDocumentReference':
          relatedDocumentReference, // Store the related document reference
      'patientPhoneNumber': patientPhoneNumber, // Store patient phone number
    };
  }
}
