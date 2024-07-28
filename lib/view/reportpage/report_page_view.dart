import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qv_patient/view/reportpage/report_page.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/helper/responsive.dart';

final documentsProvider =
    StreamProvider.autoDispose<List<Map<String, dynamic>>>((ref) {
  return FirebaseFirestore.instance
      .collection('health_documents')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) => doc.data()).toList();
  });
});

class ReportPageView extends ConsumerWidget {
  const ReportPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentsAsyncValue = ref.watch(documentsProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GradientText(
              'Medical Records',
              colors: [TColors.dark, Colors.blue],
              style: TextStyle(
                color: TColors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          actions: [
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context, CupertinoPageRoute(
                      builder: (context) {
                        return AddHealthDocumentsPage();
                      },
                    ));
                  },
                  icon: Icon(
                    Iconsax.add_circle,
                    color: TColors.primary,
                  ),
                ),
              ],
            )
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 252, 252, 246),
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Responsive.width(context, 0.04)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: Responsive.width(context, 0.03)),
                child: Row(
                  children: [],
                ),
              ),
              SizedBox(height: Responsive.height(context, 0.02)),
              Expanded(
                child: documentsAsyncValue.when(
                  data: (documents) {
                    if (documents.isEmpty) {
                      return Center(
                        child: Text(
                          'No medical records found.',
                          style: TextStyle(
                              fontSize: Responsive.fontSize(context, 0.05)),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final document = documents[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(
                              document['description'] ?? 'No Description',
                              style: TextStyle(
                                fontSize: Responsive.fontSize(context, 0.045),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              document['date'] != null
                                  ? (document['date'] as Timestamp)
                                      .toDate()
                                      .toString()
                                  : 'No Date',
                              style: TextStyle(
                                fontSize: Responsive.fontSize(context, 0.04),
                              ),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              // Handle document tap (e.g., open document)
                            },
                          ),
                        );
                      },
                    );
                  },
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => Center(
                    child: Text(
                      'Error loading documents: $error',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
