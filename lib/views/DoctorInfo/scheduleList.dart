import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/doctorData/doctorCategoryController.dart';

class OpeningHoursList extends StatelessWidget {
  int weekd = DateTime.now().weekday - 1;

  List<String> locations = [
    'Dow University Ojha Campus',
    'Darul Sehat',
    'The Clinic 24/7'
  ];
  List<String> address = [
    "W4VQ+CMW, Gulzar-e-Hijri Gulshan-e-Iqbal, Karachi, Karachi City, Sindh, Pakistan",
    "St-19, KDA Scheme, Abul Asar Hafeez Jalandhari Rd, Block 15 Gulistan-e-Johar, Karachi, Karachi City, Sindh",
    "Plot SB 16, Block K North Nazimabad Town, Karachi, Karachi City, Sindh"
  ];
  List<String> weekday = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  DateTime? _selectedValue;

  final bookinglist = Get.put(DoctorData());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Schedule',
          style: TextStyle(color: Colors.black, letterSpacing: 2),
        ),
      ),
      body: ListView.builder(
        itemCount: bookinglist.availability.length,
        itemBuilder: (context, index) {
          // print(bookinglist.availability[0]);
          // print(bookinglist.availability[1]);

          final availabilit = bookinglist.availability[index];
          final day = availabilit['Day'];
          final times = availabilit['times'];
          final landmarkId = availabilit['landmark_id'];
          bookinglist.inactive.add(
              DateTime(23, DateTime.now().month, weekday.indexOf(day) + 1));

          return Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              border: Border.all(
                color: Color(0xffFBB97C), // Customize the border color here
              ),
            ),
            child: ListTile(
              title: Text('Day: $day'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 6,
                  ),
                  Text('Location: ${locations[landmarkId - 1]}'),
                  Text('Address: ${address[landmarkId - 1]}'),
                  Text(
                    'Times: ${times[0]['start_time']} - ${times[0]['end_time']}',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
