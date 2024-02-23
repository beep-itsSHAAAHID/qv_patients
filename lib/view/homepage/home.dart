import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qv_patient/view/BookingPage/bookingpage.dart';
import 'package:qv_patient/view/profile.dart';

class Home extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0XFF4682B4),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align children at the start
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "HELLO,\nJACKSON!",
                    style: GoogleFonts.poppins(
                      fontSize: height * 0.030,
                      fontWeight: FontWeight.w600,
                      color: Color(0XFFFFFFFF),
                    ),
                  ),
                  GestureDetector(
                    //onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Profile())),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/image/Ellipse12.png'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.05),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Icon(Icons.search, color: Colors.black),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search for your Doctor....',
                          hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          // You can add search functionality here
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () => _searchController.clear(),
                      icon: Icon(Icons.clear),
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.05),
              Container(
                height: 175,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)
                ),
              ),
              SizedBox(height: height * 0.03),
              Padding(
                padding: EdgeInsets.only(left: width * 0.02),
                child: Text(
                  "Specialities",
                  style: GoogleFonts.poppins(
                    fontSize: height * 0.020,
                    fontWeight: FontWeight.w500,
                    color: Color(0XFFFFFFFF),
                  ),
                ),
              ),
              SizedBox(height: height * 0.01),
              Container(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your action here
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black, backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.category, // Replace this with the icon you want
                                size: 20,
                                color: Colors.black,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Specialty ${index + 1}",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

              ),
              SizedBox(height: height * 0.03),
              Padding(
                padding: EdgeInsets.only(left: width * 0.02),
                child: Text(
                  "Nearby Doctors",
                  style: GoogleFonts.poppins(
                    fontSize: height * 0.020,
                    fontWeight: FontWeight.w500,
                    color: Color(0XFFFFFFFF),
                  ),
                ),
              ),

              SizedBox(height: height * 0.01),
              Container(
                height: 150,

                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const BookingScreen(),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 80, // Adjust the width of the image container as needed
                                height: 80, // Adjust the height of the image container as needed
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: Image(
                                    image: AssetImage('assets/image/doctor.jpg'), // Replace with actual image path
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Dr John Doe\nGeneral Physician",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),


              ),

            ],
          ),
        ),
      ),
    );
  }
}