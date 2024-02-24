import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TokenGenerationDataModel {
  late String doctorName;
  late String tokenNumber;
  late String patientName;
  late String appointmentTime;


  TokenGenerationDataModel({
    required this.doctorName,
    required this.tokenNumber,
    required this.patientName,
    required this.appointmentTime,

  });

  List<int> toBytes() {
    BytesBuilder bytesBuilder = BytesBuilder();

    // 1. Doctor Name
    _addTLV(bytesBuilder, 1, utf8.encode(doctorName));

    // 2. Token Number
    _addTLV(bytesBuilder, 2, utf8.encode(tokenNumber));

    // 3. Patient Name
    _addTLV(bytesBuilder, 3, utf8.encode(patientName));

    // 4. Appointment Time
    _addTLV(bytesBuilder, 4, utf8.encode(appointmentTime));


    return bytesBuilder.toBytes();
  }



  void _addTLV(BytesBuilder bytesBuilder, int tag, List<int> value) {
    bytesBuilder.addByte(tag);
    bytesBuilder.addByte(value.length);
    bytesBuilder.add(value);
  }

  String generateTokenBase64Code() {
    Uint8List bytes = Uint8List.fromList(toBytes());
    String qrCodeBase64 = base64.encode(bytes);
    return qrCodeBase64;
  }

  Widget generateQrCodeWidget() {
    String qrCode = generateTokenBase64Code();
    return QrImageView(data: qrCode, version: QrVersions.auto, size: 200.0);
  }

  Uint8List hexStringToBytes(String hexString) {
    List<int> bytes = [];
    for (int i = 0; i < hexString.length; i += 2) {
      String hex = hexString.substring(i, i + 2);
      bytes.add(int.parse(hex, radix: 16));
    }
    return Uint8List.fromList(bytes);
  }
}

class TokenController {
  TokenController._();

  static String generateTokenBase64Code(TokenGenerationDataModel tokenData) {
    Uint8List bytes = Uint8List.fromList(tokenData.toBytes());
    String qrCodeBase64 = base64.encode(bytes);
    return qrCodeBase64;
  }
}


