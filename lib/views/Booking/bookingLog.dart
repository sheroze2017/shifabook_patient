import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/Booking/createBooking.dart';
import 'bookingdetail.dart';

class BookingLogs extends StatefulWidget {
  @override
  State<BookingLogs> createState() => _BookingLogsState();
}

class _BookingLogsState extends State<BookingLogs> {
  final getbooking = Get.put(Createbooking());
  bool checkdata = true;
  int listing = 1;
  List<String> inactivestatus = [
    'Cancelled',
    'Rejected',
    'Refunded',
  ];
  List<String> activestatus = [
    'Awating Payment',
    'Pending Confirmation',
    'Rescheduled Request',
    'Rescheduling',
    'Cancellation Request'
  ];
  List<String> finishstatus = ['Confirmed and Scheduled', 'Completed'];
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
  List<String> statuscheck = [
    'Awating Payment',
    'Pending Confirmation',
    'Rescheduled Request',
    'Rescheduling',
    'Cancellation Request'
  ];
  @override
  void initState() {
    getbooking
        .getBooking()
        .then((value) => Future.delayed(Duration(seconds: 1), () {
              setState(() {
                checkdata = false;
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings',
            style: TextStyle(color: Colors.black, letterSpacing: 3)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: checkdata
          ? Center(
              child: SpinKitWanderingCubes(
              color: Color.fromARGB(255, 241, 195, 86),
              size: 15.w,
            ))
          : Padding(
              padding: const EdgeInsets.all(12),
              child: Column(children: [
                Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 236, 230, 230),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes the position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 2.h,
                              width: 2.h,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            InkWell(
                              onTap: () {
                                listing = 1;
                                statuscheck = activestatus;
                                setState(() {});
                              },
                              child: const Text(
                                'Active Status', // Replace with your text code
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 2.h,
                              width: 2.h,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            InkWell(
                              onTap: () {
                                listing = 2;
                                statuscheck = finishstatus;
                                setState(() {});
                              },
                              child: Text(
                                'Completed', // Replace with your text code
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 2.h,
                              width: 2.h,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            InkWell(
                              onTap: () {
                                listing = 3;
                                statuscheck = inactivestatus;
                                setState(() {});
                              },
                              child: Text(
                                'Inactive Status', // Replace with your text code
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Expanded(
                  child: Obx(
                    () => getbooking.isLoading2.value
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: getbooking.bookings.length,
                            itemBuilder: (context, index) {
                              String dateString =
                                  getbooking.bookings[index].scheduledAt;
                              DateTime dateTime = DateTime.parse(dateString);
                              print(statuscheck);
                              if (statuscheck.contains(
                                  getbooking.bookings[index].bookingStatus)) {
                                print(getbooking.bookings[index].bookingStatus);
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Container(
                                    height: 17.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0,
                                              3), // changes the position of shadow
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      onTap: () {},
                                      trailing: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: (inactivestatus.contains(
                                                        getbooking
                                                            .bookings[index]
                                                            .bookingStatus)
                                                    ? Colors.red
                                                    : finishstatus.contains(
                                                            getbooking
                                                                .bookings[index]
                                                                .bookingStatus)
                                                        ? Colors.green
                                                        : Colors.blue),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            height: 3.h,
                                            width: 3.h,
                                          ),
                                          Spacer(),
                                          InkWell(
                                            onTap: () async {
                                              await getbooking
                                                  .getbookingdetails(getbooking
                                                      .bookings[index].id);
                                              var detail =
                                                  getbooking.bookingData;
                                              Get.dialog(
                                                AlertDialog(
                                                  shape: Border.all(
                                                    color: Colors.black,
                                                  ),
                                                  title:
                                                      Text('Booking Details'),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        Center(
                                                          child: Text(
                                                            'Location',
                                                            style: TextStyle(
                                                                fontSize: 18.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                letterSpacing:
                                                                    2),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 1.h,
                                                        ),
                                                        Text(
                                                          "${locations[detail['data']['landmark_id'] - 1]}\n${address[detail['data']['landmark_id'] - 1]}",
                                                          style: TextStyle(
                                                              fontSize: 16.sp,
                                                              color:
                                                                  Colors.grey,
                                                              letterSpacing: 1),
                                                        ),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        Divider(),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        Center(
                                                          child: Text(
                                                            'Doctor Details',
                                                            style: TextStyle(
                                                                fontSize: 18.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                letterSpacing:
                                                                    2),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 1.h,
                                                        ),
                                                        Text(
                                                          "${detail['data']['booking_log_doctor']['full_name']}\nFees: ${detail['data']['booking_log_doctor']['doctor_user']['online_consultation_fee']}-${detail['data']['booking_log_doctor']['doctor_user']['onsite_consultation_fee']}",
                                                          style: TextStyle(
                                                              fontSize: 16.sp,
                                                              color:
                                                                  Colors.grey,
                                                              letterSpacing: 1),
                                                        ),
                                                        Text(
                                                          "Qualifications: ${detail['data']['booking_log_doctor']['doctor_user']['qualification'].join(' ')}",
                                                          style: TextStyle(
                                                              fontSize: 16.sp,
                                                              color:
                                                                  Colors.grey,
                                                              letterSpacing: 1),
                                                        ),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        Divider(),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        Center(
                                                          child: Text(
                                                            'Booking Status',
                                                            style: TextStyle(
                                                                fontSize: 18.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                letterSpacing:
                                                                    2),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 1.h,
                                                        ),
                                                        Text(
                                                          "${detail['data']['booking_status']}",
                                                          style: TextStyle(
                                                              fontSize: 16.sp,
                                                              color:
                                                                  Colors.grey,
                                                              letterSpacing: 1),
                                                        ),
                                                        Divider(),
                                                        Center(
                                                          child: Text(
                                                            'Remarks',
                                                            style: TextStyle(
                                                                fontSize: 18.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                letterSpacing:
                                                                    2),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        detail['data'][
                                                                    'doctor_OPDs'] !=
                                                                null
                                                            ? Text(
                                                                "${detail['data']['doctor_OPDs']['remarks']}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.sp,
                                                                    color: Colors
                                                                        .grey,
                                                                    letterSpacing:
                                                                        1),
                                                              )
                                                            : Container(),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        detail['data'][
                                                                    'doctor_OPDs'] !=
                                                                null
                                                            ? Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child:
                                                                    SquareButtonWithIcon(
                                                                  buttonText:
                                                                      'Report',
                                                                  iconData: Icons
                                                                      .download,
                                                                  downloadLink: detail['data']
                                                                              [
                                                                              'doctor_OPDs']
                                                                          [
                                                                          'media'][0]
                                                                      [
                                                                      'prescirptipon'],
                                                                ),
                                                              )
                                                            : Container(),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: Text('Close'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        if (detail['data'][
                                                                'booking_status'] ==
                                                            'Awating Payment') {
                                                          await getbooking.delayedPayment(
                                                              await detail['data']
                                                                          ['booking_log_doctor']
                                                                      ['doctor_user']
                                                                  ['doctor_id'],
                                                              await detail[
                                                                  'data']['id'],
                                                              await detail['data']
                                                                          ['booking_log_doctor']
                                                                      [
                                                                      'doctor_user']
                                                                  [
                                                                  'onsite_consultation_fee']);
                                                        } else {}
                                                      },
                                                      child: Text(
                                                        detail['data'][
                                                                    'booking_status'] ==
                                                                'Awating Payment'
                                                            ? 'Pay Now'
                                                            : 'Already Paid',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            child: Text(
                                              'Details',
                                              style: TextStyle(
                                                  color: (inactivestatus
                                                          .contains(getbooking
                                                              .bookings[index]
                                                              .bookingStatus)
                                                      ? Colors.red
                                                      : finishstatus.contains(
                                                              getbooking
                                                                  .bookings[
                                                                      index]
                                                                  .bookingStatus)
                                                          ? Colors.green
                                                          : Colors.blue),
                                                  fontSize: 18.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                                      title: Text(
                                        'Status: ${getbooking.bookings[index].bookingStatus}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                      subtitle: Text(
                                        'Doctor Name: ${getbooking.bookings[index].doctorFullName}\nScheduled At: ${dateTime.day}-${dateTime.month}-${dateTime.year} \nTime: ${dateTime.hour}-${dateTime.minute}  \nLocation: ${getbooking.bookings[index].landmarkName}',
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox.shrink();
                              }
                            },
                          ),
                  ),
                ),
              ]),
            ),
    );
  }
}

class SquareButtonWithIcon extends StatelessWidget {
  final String buttonText;
  final String downloadLink;
  final IconData iconData;

  SquareButtonWithIcon({
    required this.buttonText,
    required this.downloadLink,
    required this.iconData,
  });

  void _launchURL() async {
    if (await canLaunch(downloadLink)) {
      await launch(downloadLink);
    } else {
      throw 'Could not launch $downloadLink';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchURL,
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: Colors.white,
            ),
            SizedBox(height: 5.0),
            Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
