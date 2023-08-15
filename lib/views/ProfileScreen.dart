import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool checkdata = true;
  List<String>? userdata;
  @override
  void initState() {
    super.initState();
    readData().then((value) => Future.delayed(Duration(seconds: 1), () {
          setState(() {
            checkdata = false;
          });
        }));
  }

  readData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // setState(() async {
    //  bloodType = prefs.getString('blood_type') ?? '';
    // setState(() {
    userdata = prefs.getStringList('userData')!;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return checkdata
        ? Container()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              iconTheme: const IconThemeData(color: Colors.black87),
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Container(
                  //height: 85.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.amber),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: CircleAvatar(
                            radius: 30.sp,
                            backgroundImage: const NetworkImage(
                              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg'",
                            ),
                          ),
                        ),
                        Divider(),
                        SizedBox(
                          width: 100.w,
                          height: 30.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  'User Details',
                                  style: TextStyle(
                                      fontSize: 22.sp, letterSpacing: 3),
                                ),
                              ),
                              Text(
                                "  " + userdata![0],
                                style: TextStyle(
                                    fontSize: 18.sp, color: Colors.grey),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.phone),
                                  Text(
                                    ' ' + userdata![1],
                                    style: TextStyle(
                                        fontSize: 17.sp, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.confirmation_number_sharp),
                                  Text(
                                    ' ' + userdata![4] + ' Yr',
                                    style: TextStyle(
                                        fontSize: 17.sp, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.calendar_month_outlined),
                                  Text(
                                    ' ' + userdata![5],
                                    style: TextStyle(
                                        fontSize: 17.sp, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.pin_drop),
                                  Text(
                                    ' ' + userdata![11],
                                    style: TextStyle(
                                        fontSize: 17.sp, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 100.w,
                          height: 30.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  'Personal Details',
                                  style: TextStyle(
                                      fontSize: 22.sp, letterSpacing: 3),
                                ),
                              ),
                              Text(
                                'Weight  ' + userdata![8],
                                style: TextStyle(
                                    fontSize: 18.sp, color: Colors.grey),
                              ),
                              Text(
                                'Height  ' + userdata![9],
                                style: TextStyle(
                                    fontSize: 17.sp, color: Colors.grey),
                              ),
                              Text(
                                'Blood  ' + userdata![7],
                                style: TextStyle(
                                    fontSize: 17.sp, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
