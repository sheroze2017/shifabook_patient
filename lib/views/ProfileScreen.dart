import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifabook/Global.dart';
import 'package:shifabook/views/updateScreen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool checkdata = true;
  late SharedPreferences prefs;

  List<String>? userdata;
  @override
  @override
  void initState() {
    readData().then((value) => Future.delayed(Duration(seconds: 2), () {
          setState(() {
            checkdata = false;
          });
        }));
    initPrefs();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  Future<void> readData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userdata = prefs.getStringList('userData')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        titleSpacing: 3,
        centerTitle: true,
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
      body: checkdata
          ? Center(
              child: SpinKitWanderingCubes(
              color: Color.fromARGB(255, 241, 195, 86),
              size: 15.w,
            ))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Container(
                  height: 85.h,
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
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTECnJmN6N3cN0wlEw1-ky4xQNb1MUEXoucfQ&usqp=CAU",
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
                          //height: 30.h,
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
                              SizedBox(height: 5.h),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Weight  ',
                                            style: TextStyle(
                                                fontSize: 17.sp,
                                                color: Colors.black),
                                          ),
                                          SizedBox(height: 2.h),
                                          Text(
                                            'Height  ',
                                            style: TextStyle(
                                                fontSize: 17.sp,
                                                color: Colors.black),
                                          ),
                                          SizedBox(height: 2.h),
                                          Text(
                                            'Blood  ',
                                            style: TextStyle(
                                                fontSize: 17.sp,
                                                color: Colors.black),
                                          ),
                                        ]),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userdata![8],
                                          style: TextStyle(
                                              fontSize: 17.sp,
                                              color: Colors.grey),
                                        ),
                                        SizedBox(height: 2.h),
                                        Text(
                                          userdata![9],
                                          style: TextStyle(
                                              fontSize: 17.sp,
                                              color: Colors.grey),
                                        ),
                                        SizedBox(height: 2.h),
                                        Text(
                                          userdata![7],
                                          style: TextStyle(
                                              fontSize: 17.sp,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    )
                                  ])
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Center(
                          child: SizedBox(
                            width: 40.w,
                            height: 5.h,
                            child: ElevatedButton(
                              // focusNode: f3,
                              onPressed: () async {
                                Get.to(UpdateScreen(),
                                    transition: Transition.downToUp);
                              },

                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: primaryColor,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                              ),
                              // focusNode: f3,
                              child: Text(
                                "Update",
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
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
