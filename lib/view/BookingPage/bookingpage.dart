import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/qrGenerator.dart';

class BookingScreen extends StatefulWidget {
  final String? specialty;
  final String? doctor;

  const BookingScreen({Key? key, this.specialty, this.doctor}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String? _selectedSession;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF4682B4),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context); // Navigate back when back button is pressed
          },
        ),
        backgroundColor: Color(0XFF4682B4),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 70),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(70)),
              child: Image.asset(
                'assets/image/doctor.jpg',
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Divider(
                        indent: 150,
                        endIndent: 150,
                        thickness: 3,
                        color: Colors.blue,
                      ),
                      Text(
                        widget.doctor ?? '',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.specialty ?? '',
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 20),
                      Divider(),
                      Row(
                        children: [
                          Text(
                            'About',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                      Text(
                        'Add information about the doctor here...',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            'Appointment',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            7,
                                (index) {
                              final currentDate = DateTime.now().add(Duration(days: index));
                              final dayAbbreviation = _getDayAbbreviation(currentDate.weekday);
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedDate = currentDate;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 20),
                                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                                  decoration: BoxDecoration(
                                    color: _selectedDate != null && currentDate.day == _selectedDate!.day
                                        ? Colors.indigo
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        dayAbbreviation,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        '${currentDate.day}',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedSession = 'Morning';
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                                margin: EdgeInsets.only(right: 10),
                                child: Text(
                                  'Morning Session',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                ),
                                decoration: BoxDecoration(
                                  color: _selectedSession == 'Morning' ? Colors.indigo : Colors.transparent,
                                  borderRadius: BorderRadius.circular(22),
                                  border: Border.all(color: Colors.indigo),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedSession = 'Evening';
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                                margin: EdgeInsets.only(right: 10),
                                child: Text(
                                  'Evening Session',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                decoration: BoxDecoration(
                                  color: _selectedSession == 'Evening' ? Colors.indigo : Colors.transparent,
                                  borderRadius: BorderRadius.circular(22),
                                  border: Border.all(color: Colors.indigo),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showBookingConfirmation();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 17),
                          child: Text(
                            'Book APPOINTMENT!',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(color: Colors.indigo),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getDayAbbreviation(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }

  void _showBookingConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Booking Successful!"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Doctor's Name: ${widget.doctor}"),
              Text("Patient's Name: Sajjad"), // Replace [Your Patient's Name] with actual patient's name
              Text("Token Number: 10"), // Replace [Token Number] with actual token number
              Text("Session: $_selectedSession"),
              Text("Date: ${_selectedDate != null ? _selectedDate!.toLocal().toString().split(' ')[0] : ''}"),
              SizedBox(height: 10),
              SizedBox(
                width: 200,
                height: 200,
                child: TokenGenerationDataModel(
                    doctorName: '${widget.doctor}',
                    tokenNumber: '10',
                    patientName: 'Sajjad',
                    appointmentTime: '$_selectedSession"'
                ).generateQrCodeWidget(),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

}
