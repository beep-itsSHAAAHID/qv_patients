class Booking {
  String doctorId;
  String patientId;
  String date;
  String session;
  int tokenNumber;
  String qrCode; // Add this
  String status;

  Booking({
    required this.doctorId,
    required this.patientId,
    required this.date,
    required this.session,
    required this.tokenNumber,
    required this.qrCode, // Make sure it's required or has a default value
    this.status = "Confirmed",
  });

  Map<String, dynamic> toMap() {
    return {
      'doctorId': doctorId,
      'patientId': patientId,
      'date': date,
      'session': session,
      'tokenNumber': tokenNumber,
      'qrCode': qrCode, // Make sure this is included
      'status': status,
    };
  }
}
