import 'package:flutter/material.dart';

class PackageSelectionPage extends StatefulWidget {
  @override
  _PackageSelectionPageState createState() => _PackageSelectionPageState();
}

class _PackageSelectionPageState extends State<PackageSelectionPage> {
  String selectedReminder = '30 Minutes';
  String selectedPackage = 'Voice Call';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 252, 252, 246),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Reminder Me Before',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              DropdownButton<String>(
                value: selectedReminder,
                isExpanded: true,
                items:
                    ['15 Minutes', '30 Minutes', '1 Hour'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedReminder = newValue!;
                  });
                },
              ),
              SizedBox(height: 24),
              Text('Select Package',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildPackageOption(
                  'Messaging', 'Chat Message With Doctor', '30 Min', '\$20'),
              _buildPackageOption(
                  'Voice Call', 'Voice Call With Doctor', '30 Min', '\$40'),
              _buildPackageOption(
                  'Video Call', 'Video Call With Doctor', '30 Min', '\$60'),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Next'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPackageOption(
      String title, String description, String duration, String price) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: RadioListTile(
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            Text(duration),
          ],
        ),
        secondary: Text(price,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
        value: title,
        groupValue: selectedPackage,
        onChanged: (String? value) {
          setState(() {
            selectedPackage = value!;
          });
        },
      ),
    );
  }
}
