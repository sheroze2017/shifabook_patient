import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import 'package:shifabook/Global.dart';

import '../../controller/Booking/createBooking.dart';
import '../../controller/doctorData/doctorCategoryController.dart';

class BookScreen extends StatefulWidget {
  final int? id;
  final int? onsitefees;
  BookScreen(this.id, this.onsitefees);
  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
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
  final bookingController = Get.put(Createbooking());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Schedule Booking',
            style: TextStyle(
                color: Colors.black, letterSpacing: 1, fontSize: 18.sp),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
        ),
        body: Column(children: [
          SizedBox(
            height: 2.h,
          ),
          DatePicker(
            selectionColor: primaryColor,
            height: 12.h,
            daysCount: 14,
            inactiveDates: ddata.inactive,
            DateTime.now(),
            initialSelectedDate: DateTime.now(),
            selectedTextColor: const Color.fromRGBO(255, 255, 255, 1),
            onDateChange: (date) {
              print(date.weekday);
              setState(() {
                weekd = date.weekday - 1;
                _selectedValue = date;
              });
            },
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: ddata.availability.length,
              itemBuilder: (context, index) {
                // print(ddata.availability[0]);
                // print(ddata.availability[1]);

                final availabilit = ddata.availability[index];
                final day = availabilit['Day'];
                final times = availabilit['times'];
                final landmarkId = availabilit['landmark_id'];
                ddata.inactive.add(DateTime(
                    23, DateTime.now().month, weekday.indexOf(day) + 1));
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
                        color: Color(
                            0xffFBB97C), // Customize the border color here
                      ),
                    ),
                    child: ListTile(
                      trailing: InkWell(
                        onTap: () async {
                          String start_time = times[0]["start_time"];
                          String formatTime =
                              "${start_time.length == 4 ? '0' : ''}$start_time:00";
                          print(formatTime);

                          String finalTime =
                              '${_selectedValue!.year}${_selectedValue!.month.toString().length == 1 ? '-0' : '-'}${_selectedValue!.month}${_selectedValue!.day.toString().length == 1 ? '-0' : '-'}${_selectedValue!.day}T$formatTime+05:00';
                          print(finalTime);
                          // setState(() {});
                          bool confirmBooking = await showDialog(
                            context: context,
                            builder: (context) {
                              //  setState(() {});
                              return AlertDialog(
                                title: Text('Confirm Booking'),
                                content: Text('Do you want to book this slot?'),
                                actions: [
                                  TextButton(onPressed: () async {
                                    await bookingController.createBook(
                                        finalTime,
                                        widget.id!,
                                        landmarkId,
                                        widget.onsitefees!);

                                    Navigator.pop(
                                        context, true); // Confirm the booking
                                  }, child: Obx(
                                    () {
                                      if (bookingController.isloading.value) {
                                        return SpinKitWave(
                                          color: Colors.blue,
                                          size: 6.w,
                                        );
                                      } else {
                                        return Text('Confirm');
                                      }
                                    },
                                  )),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(
                                          context, false); // Cancel the booking
                                    },
                                    child: Text('Cancel'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          width: 16.w,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20),
                              color: primaryColor),
                          //color: primaryColor,
                          height: 5.h,
                          child: Center(
                            child: Text(
                              'Book',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.sp),
                            ),
                          ),
                        ),
                      ),
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
          ),
        ]));
  }
}
