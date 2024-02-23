import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({
    Key? key,
  }) : super(key: key);

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
                'assets/image/doctor.jpg', // Corrected image loading method
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
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
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
                      "Dr. Lulu Kp",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "General Physician",
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      "100% | 10 years of experience",
                      style: TextStyle(
                        fontSize: 14,
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
                            final currentDate =
                                DateTime.now().add(Duration(days: index));
                            final dayAbbreviation =
                                _getDayAbbreviation(currentDate.weekday);
                            return GestureDetector(
                              onTap: () {
                                // Handle date selection here
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 20),
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 25),
                                decoration: BoxDecoration(
                                  color: index == 1
                                      ? Colors.indigo
                                      : Colors.grey[
                                          300], // Change color based on selection
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                        child: Text('08:00-10:00AM',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: Colors.indigo),
                        ),
                      ), Container(
                        padding: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                        child: Text('14:00-17:00AM',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: Colors.indigo),
                        ),
                      )
                    ]),
                    SizedBox(height: 40,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40,vertical: 17),
                      child: Text('Book APPOINTMENT!',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: Colors.indigo),
                      ),
                    )
                  ],
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
}
