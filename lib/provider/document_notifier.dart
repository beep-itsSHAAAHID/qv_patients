import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

class DocumentNotifier extends StateNotifier<DocumentState> {
  DocumentNotifier() : super(DocumentState());

  Future<void> pickFile(String documentType) async {
    if (state.isPickerActive) return;

    state = state.copyWith(isPickerActive: true, errorMessage: null);

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
      );

      if (result != null) {
        final fileName = result.files.single.name;
        final filePath = result.files.single.path!;

        final uploadTask = FirebaseStorage.instance
            .ref('documents/$fileName')
            .putFile(File(filePath));

        final snapshot = await uploadTask;
        final downloadUrl = await snapshot.ref.getDownloadURL();

        switch (documentType) {
          case 'medicalHistory':
            state = state.copyWith(
              medicalHistoryFile: downloadUrl,
            );
            break;
          case 'labResults':
            state = state.copyWith(
              labResultsFile: downloadUrl,
            );
            break;
          case 'insuranceInfo':
            state = state.copyWith(
              insuranceInfoFile: downloadUrl,
            );
            break;
        }
      }
    } catch (e) {
      state = state.copyWith(errorMessage: 'Error picking file: $e');
    } finally {
      state = state.copyWith(isPickerActive: false);
    }
  }

  void updateDescription(String documentType, String description) {
    switch (documentType) {
      case 'medicalHistory':
        state = state.copyWith(medicalHistoryDescription: description);
        break;
      case 'labResults':
        state = state.copyWith(labResultsDescription: description);
        break;
      case 'insuranceInfo':
        state = state.copyWith(insuranceInfoDescription: description);
        break;
    }
  }

  Future<void> submitDocuments(BuildContext context) async {
    if (state.medicalHistoryFile == null ||
        state.labResultsFile == null ||
        state.insuranceInfoFile == null ||
        state.medicalHistoryDescription == null ||
        state.labResultsDescription == null ||
        state.insuranceInfoDescription == null) {
      state =
          state.copyWith(errorMessage: 'Please complete all required fields');
      return;
    }

    state = state.copyWith(isSubmitting: true);

    try {
      // Save the document details in Firestore
      await FirebaseFirestore.instance.collection('health_documents').add({
        'medicalHistoryFile': state.medicalHistoryFile,
        'labResultsFile': state.labResultsFile,
        'insuranceInfoFile': state.insuranceInfoFile,
        'medicalHistoryDescription': state.medicalHistoryDescription,
        'labResultsDescription': state.labResultsDescription,
        'insuranceInfoDescription': state.insuranceInfoDescription,
        'date': DateTime.now(),
      });

      state = state.copyWith(isSubmitting: false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Documents submitted successfully!')),
      );
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: 'Error submitting documents: $e',
      );
    }
  }
}

class DocumentState {
  final String? medicalHistoryFile;
  final String? labResultsFile;
  final String? insuranceInfoFile;
  final String? medicalHistoryDescription;
  final String? labResultsDescription;
  final String? insuranceInfoDescription;
  final bool isPickerActive;
  final bool isSubmitting;
  final String? errorMessage;

  DocumentState({
    this.medicalHistoryFile,
    this.labResultsFile,
    this.insuranceInfoFile,
    this.medicalHistoryDescription,
    this.labResultsDescription,
    this.insuranceInfoDescription,
    this.isPickerActive = false,
    this.isSubmitting = false,
    this.errorMessage,
  });

  DocumentState copyWith({
    String? medicalHistoryFile,
    String? labResultsFile,
    String? insuranceInfoFile,
    String? medicalHistoryDescription,
    String? labResultsDescription,
    String? insuranceInfoDescription,
    bool? isPickerActive,
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return DocumentState(
      medicalHistoryFile: medicalHistoryFile ?? this.medicalHistoryFile,
      labResultsFile: labResultsFile ?? this.labResultsFile,
      insuranceInfoFile: insuranceInfoFile ?? this.insuranceInfoFile,
      medicalHistoryDescription:
          medicalHistoryDescription ?? this.medicalHistoryDescription,
      labResultsDescription:
          labResultsDescription ?? this.labResultsDescription,
      insuranceInfoDescription:
          insuranceInfoDescription ?? this.insuranceInfoDescription,
      isPickerActive: isPickerActive ?? this.isPickerActive,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
