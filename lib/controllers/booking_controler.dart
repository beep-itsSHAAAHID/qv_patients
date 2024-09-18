import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qv_patient/repository/booking_repo.dart';

final bookingControllerProvider =
    StateNotifierProvider<BookingController, BookingState>(
  (ref) => BookingController(BookingRepository()),
);

class BookingState {
  final String? patientName;
  final String? patientId;
  final String? clinicName;
  final String? doctorName;
  final String? doctorConsultations;
  final String? doctorExperience;
  final String? doctorAbout; // Add this field
  final bool isLoading;
  final bool hasError;

  BookingState({
    this.patientName,
    this.patientId,
    this.clinicName,
    this.doctorName,
    this.doctorConsultations,
    this.doctorExperience,
    this.doctorAbout, // Add this here as well
    this.isLoading = false,
    this.hasError = false,
  });

  BookingState copyWith({
    String? patientName,
    String? patientId,
    String? clinicName,
    String? doctorName,
    String? doctorConsultations,
    String? doctorExperience,
    String? doctorAbout, // Add this here
    bool? isLoading,
    bool? hasError,
  }) {
    return BookingState(
      patientName: patientName ?? this.patientName,
      patientId: patientId ?? this.patientId,
      clinicName: clinicName ?? this.clinicName,
      doctorName: doctorName ?? this.doctorName,
      doctorConsultations: doctorConsultations ?? this.doctorConsultations,
      doctorExperience: doctorExperience ?? this.doctorExperience,
      doctorAbout: doctorAbout ?? this.doctorAbout, // Add this here
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}

class BookingController extends StateNotifier<BookingState> {
  final BookingRepository _repository;

  BookingController(this._repository) : super(BookingState());

  Future<void> fetchPatientDetails() async {
    try {
      state = state.copyWith(isLoading: true);
      final patientData = await _repository.fetchPatientDetails();
      state = state.copyWith(
        patientName: patientData['fullName'],
        patientId: patientData['patientId'],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(hasError: true, isLoading: false);
    }
  }

  Future<void> fetchClinicName(String clinicId) async {
    try {
      state = state.copyWith(isLoading: true);
      final clinicData = await _repository.fetchClinicName(clinicId);
      state = state.copyWith(
        clinicName: clinicData['name'],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(hasError: true, isLoading: false);
    }
  }

  Future<void> fetchDoctorDetails(String clinicId, String doctorName) async {
    try {
      state = state.copyWith(isLoading: true);
      final doctorData =
          await _repository.fetchDoctorDetails(clinicId, doctorName);
      state = state.copyWith(
        doctorName: doctorData['name'],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(hasError: true, isLoading: false);
    }
  }
}
