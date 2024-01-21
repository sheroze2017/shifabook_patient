import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../controller/doctorData/doctorCategoryController.dart';

class ScheduleScreen extends StatelessWidget {
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
  final ddata = Get.put(DoctorData());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        itemCount: ddata.availability.length,
        itemBuilder: (context, index) {
          // print(ddata.availability[0]);
          // print(ddata.availability[1]);

          final availabilit = ddata.availability[index];
          final day = availabilit['Day'];
          final times = availabilit['times'];
          final landmarkId = availabilit['landmark_id'];
          ddata.inactive.add(
              DateTime(23, DateTime.now().month, weekday.indexOf(day) + 1));
          if (day == weekday[weekd!]) {
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
                // trailing: InkWell(
                //   onTap: () async {
                //     String start_time = times[0]["start_time"];

                //     String formatTime = start_time + ":00";
                //     print(formatTime);
                //     String finalTime = _selectedValue!.year.toString() +
                //         '-0' +
                //         _selectedValue!.month.toString() +
                //         '-' +
                //         _selectedValue!.day.toString() +
                //         'T' +
                //         formatTime +
                //         '+05:00';
                //     print(finalTime);
                //   },
                //   child: Container(
                //     width: 16.w,
                //     decoration: BoxDecoration(
                //         border: Border.all(color: Colors.grey),
                //         borderRadius: BorderRadius.circular(20),
                //         color: Color(0xffFBB97C)),
                //     //color: Color(0xffFBB97C),
                //     height: 5.h,
                //     child: Center(
                //       child: Text(
                //         'Book',
                //         style: TextStyle(color: Colors.white, fontSize: 15.sp),
                //       ),
                //     ),
                //   ),
                // ),

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
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
