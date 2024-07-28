import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/provider/document_notifier.dart';

final documentProvider =
    StateNotifierProvider<DocumentNotifier, DocumentState>((ref) {
  return DocumentNotifier();
});

class AddHealthDocumentsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentState = ref.watch(documentProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 252, 246),
      appBar: AppBar(
        backgroundColor: TColors.primary,
        title: Text(
          'Upload your health documents',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              _buildDocumentUploadButton(
                'Medical History',
                documentState.medicalHistoryFile,
                () => ref
                    .read(documentProvider.notifier)
                    .pickFile('medicalHistory'),
                documentState.isPickerActive,
                (value) => ref
                    .read(documentProvider.notifier)
                    .updateDescription('medicalHistory', value),
              ),
              _buildDocumentUploadButton(
                'Lab Results',
                documentState.labResultsFile,
                () =>
                    ref.read(documentProvider.notifier).pickFile('labResults'),
                documentState.isPickerActive,
                (value) => ref
                    .read(documentProvider.notifier)
                    .updateDescription('labResults', value),
              ),
              _buildDocumentUploadButton(
                'Insurance Information',
                documentState.insuranceInfoFile,
                () => ref
                    .read(documentProvider.notifier)
                    .pickFile('insuranceInfo'),
                documentState.isPickerActive,
                (value) => ref
                    .read(documentProvider.notifier)
                    .updateDescription('insuranceInfo', value),
              ),
              if (documentState.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    documentState.errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: documentState.isSubmitting
                      ? null
                      : () => ref
                          .read(documentProvider.notifier)
                          .submitDocuments(context),
                  child: documentState.isSubmitting
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text('Submit Documents'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentUploadButton(
    String label,
    String? fileName,
    VoidCallback onPressed,
    bool isPickerActive,
    ValueChanged<String> onDescriptionChanged,
  ) {
    final descriptionController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: TColors.black, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            child: isPickerActive
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(fileName ?? 'Select File'),
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: descriptionController,
          onChanged: onDescriptionChanged,
          decoration: InputDecoration(
            fillColor: TColors.white,
            labelText: 'Description',
            labelStyle: TextStyle(color: TColors.black),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: TColors.black)),
          ),
          maxLines: 3,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
