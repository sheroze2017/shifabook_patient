import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/doctorData/doctorCategoryController.dart';
import '../model/doctorCategory.dart';
import 'doctor_info.dart';

class CategoryDoctor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;

    final doctorCat = arguments['category'];

    // Assuming you have a GetX controller that holds the doctor data
    final doctorController =
        Get.put(DoctorData()); // Make sure to define DoctorController

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Doctors',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Obx(() => Column(
            children: [
              Text(doctorCat,
                  style: TextStyle(fontSize: 18.sp, letterSpacing: 3)),
              Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: doctorController.fullName.length,
                  itemBuilder: (context, index) {
                    final doctorname = doctorController.fullName[index];

                    final img = doctorController.img[index];
                    var doctor = doctorController.doctors[index];
                    var exp = doctorController.accountData!.data![index]
                        .doctorUser!.yearsOfExperience;
                    var onlinefees = doctorController.accountData!.data![index]
                        .doctorUser!.onlineConsultationFee;
                    var onsitefees = doctorController.accountData!.data![index]
                        .doctorUser!.onsiteConsultationFee;
                    return doctorController.fullName.length != 0
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorsInfo(
                                      doctorname, img, doctor, doctorCat, exp),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10, bottom: 6),
                              child: Container(
                                height: 20.h,
                                decoration: BoxDecoration(
                                  color: Color(0xffFFEEE0),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Image.asset(
                                      "assets/doctor_pic.png",
                                      height: 8.h,
                                    ),
                                    SizedBox(width: 3.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          doctorname,
                                          style: TextStyle(
                                            color: Color(0xffFC9535),
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Text(
                                          doctorCat,
                                          style: TextStyle(fontSize: 16.sp),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Text(
                                          doctor.qualification!.join(' '),
                                          style: TextStyle(fontSize: 16.sp),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Spacer(),
                                        Text(
                                          'Fees ${onlinefees}-${onsitefees}',
                                          style: TextStyle(fontSize: 16.sp),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Text(
                                          'Experience ' +
                                              exp.toString() +
                                              ' Years',
                                          style: TextStyle(fontSize: 16.sp),
                                        ),
                                        // Text(
                                        //   'Fees ${onlinefees}-${onsitefees}',
                                        //   style: TextStyle(fontSize: 16.sp),
                                        // )
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 9),
                                          decoration: BoxDecoration(
                                            color: Color(0xffFBB97C),
                                            borderRadius:
                                                BorderRadius.circular(13),
                                          ),
                                          child: Text(
                                            "Details",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        //  Spacer(),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Center(child: Text('No Data Yet'));
                  },
                ),
              ),
            ],
          )),
    );
  }
}
