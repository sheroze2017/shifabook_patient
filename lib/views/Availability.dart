import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final List<Map<String, dynamic>> availability = [
    {
      "Day": "Monday",
      "times": [
        {"end_time": "10:00pm", "start_time": "7:00am"}
      ],
      "landmark_id": 2
    },
    {
      "Day": "Monday",
      "times": [
        {"end_time": "10:00pm", "start_time": "6:00pm"}
      ],
      "landmark_id": 2
    },
    {
      "Day": "Tuesday",
      "times": [
        {"end_time": "10:00pm", "start_time": "6:00pm"}
      ],
      "landmark_id": 2
    },
    {
      "Day": "Wednesday",
      "times": [
        {"end_time": "10:00pm", "start_time": "6:00pm"}
      ],
      "landmark_id": 2
    },
    {
      "Day": "Thursday",
      "times": [
        {"end_time": "10:00pm", "start_time": "6:00pm"}
      ],
      "landmark_id": 2
    },
    {
      "Day": "Friday",
      "times": [
        {"end_time": "10:00pm", "start_time": "6:00pm"}
      ],
      "landmark_id": 2
    },
    {
      "Day": "Saturday",
      "times": [
        {"end_time": "6:00pm", "start_time": "1:00pm"}
      ],
      "landmark_id": 2
    },
    {
      "Day": "Sunday",
      "times": [
        {"end_time": "6:00pm", "start_time": "1:00pm"}
      ],
      "landmark_id": 2
    },
    {
      "Day": "Wednesday",
      "times": [
        {"start_time": "0:0", "end_time": "6:0"}
      ],
      "landmark_id": 1
    }
  ];
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
  DateTime? _selectedValue;
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
            selectionColor: Color(0xffFBB97C),
            height: 12.h,
            daysCount: 14,
            inactiveDates: [
              // DateTime(2023, 8, 21, 17, 59, 25),
              // DateTime(2023, 8, 22, 8, 30, 0),
              // DateTime(2023, 8, 23, 14, 15, 45),
            ],
            DateTime.now(),
            initialSelectedDate: DateTime.now(),
            // selectionColor: Colors.black,
            selectedTextColor: Colors.white,
            onDateChange: (date) {
              // New date selected
              setState(() {
                _selectedValue = date;
              });
            },
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: availability.length,
              itemBuilder: (context, index) {
                final availabilit = availability[index];
                final day = availabilit['Day'];
                final times = availabilit['times'];
                final landmarkId = availabilit['landmark_id'];

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
                      color:
                          Color(0xffFBB97C), // Customize the border color here
                    ),
                  ),
                  child: ListTile(
                    trailing: InkWell(
                      onTap: () async {
                        String start_time = times[0]["start_time"];
                        String timePart =
                            start_time.substring(0, start_time.length - 2);
                        String periodPart = start_time
                            .substring(start_time.length - 2)
                            .toLowerCase();
                        int hours = int.parse(timePart.split(':')[0]);
                        if (periodPart == "pm") {
                          hours = (hours + 12) % 24;
                        }
                        String formatTime = hours.toString().padLeft(2, '0') +
                            ':' +
                            timePart.split(':')[1].padLeft(2, '0') +
                            ':00';

                        print(formatTime);
                        String finalTime = _selectedValue!.year.toString() +
                            '-0' +
                            _selectedValue!.month.toString() +
                            '-' +
                            _selectedValue!.day.toString() +
                            'T' +
                            formatTime +
                            '+05:00';
                        print(finalTime);

                        setState(() {
                          // availability = availability;

                          // SharedPreferences prefs =
                          //     await SharedPreferences.getInstance();
                          // (prefs.setString('DoctorAvailability',
                          //     jsonEncode(availability)));
                        });
                        // availbility().updateAvailibility2(availability);
                      },
                      child: Container(
                        width: 16.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xffFBB97C)),
                        //color: Color(0xffFBB97C),
                        height: 5.h,
                        child: Center(
                          child: Text(
                            'Book',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.sp),
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
              },
            ),
          ),
        ]));
  }
}
