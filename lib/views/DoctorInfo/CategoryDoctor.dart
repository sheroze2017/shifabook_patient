import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shifabook/Global.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shifabook/views/widgets/filterbottom_sheet.dart';
import 'package:shifabook/views/widgets/shimmer.dart';

import '../../controller/doctorData/doctorCategoryController.dart';
import '../../model/doctorCategory.dart';
import 'doctor_info.dart';

class CategoryDoctor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final doctorCat = arguments['category'];
    final categoryNo = arguments['categoryNo'];
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
              // Padding(
              //   padding: const EdgeInsets.only(right: 16.0, bottom: 8),
              //   child: InkWell(
              //       onTap: () async {
              //         doctorController.sortDoctorsByExperience();
              //         //String result = await showFilterBottomSheet(context);
              //         // print(result);
              //       },
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         children: [
              //           FaIcon(FontAwesomeIcons.filter, color: Colors.black54),
              //         ],
              //       )),
              // ),
              Expanded(
                  child: doctorController.doctorFetchLoader.value
                      ? ListView.builder(
                          itemCount: doctorController.fullName.length,
                          itemBuilder: (context, index) {
                            final doctorname = doctorController.fullName[index];
                            final doctorQualification = doctorController
                                .doctors[index].qualification!
                                .join("");
                            final img = doctorController.img[index];
                            var doctor = doctorController.doctors[index];
                            var exp = doctorController.accountData!.data![index]
                                .doctorUser!.yearsOfExperience;
                            var onlinefees = doctorController.accountData!
                                .data![index].doctorUser!.onlineConsultationFee;
                            var onsitefees = doctorController.accountData!
                                .data![index].doctorUser!.onsiteConsultationFee;
                            var avail = doctorController.avail[index];
                            var doctorId = doctorController
                                .accountData!.data![index].doctorUser!.id;

                            // print(avail);
                            return doctorController.fullName.length != 0
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DoctorsInfo(
                                              doctorname,
                                              img,
                                              doctor,
                                              doctorCat,
                                              exp,
                                              avail,
                                              doctorId),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10, bottom: 6),
                                      child: DoctorCard(
                                          doctorname: doctorname,
                                          doctorCat: doctorCat,
                                          doctorQualification:
                                              doctorQualification,
                                          // doctor: doctor,
                                          onlinefees: onlinefees,
                                          onsitefees: onsitefees,
                                          exp: exp),
                                    ),
                                  )
                                : Center(child: Text('No Data Yet'));
                          },
                        )
                      : AllBookingDetailShimmer())
            ],
          )),
    );
  }
}

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.doctorname,
    required this.doctorCat,
    required this.doctorQualification,
    //required this.doctor,
    required this.onlinefees,
    required this.onsitefees,
    required this.exp,
  });

  final String doctorname;
  final String doctorCat;
  final String doctorQualification;
  //final DoctorUser doctor;
  final int? onlinefees;
  final int? onsitefees;
  final int? exp;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 22.h,
      decoration: BoxDecoration(
          color: Color(0xffFFEEE0),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          border: Border.all(
            color: primaryColor,
          )),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Column(
        children: [
          CardHeader(doctorname: doctorname),
          CategoryName(doctorCat: doctorCat),
          QualificationName(doctor: doctorQualification),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DoctorFees(onlinefees: onlinefees, onsitefees: onsitefees),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DoctorRating(),
                    DoctorExp(exp: exp),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DoctorExp extends StatelessWidget {
  const DoctorExp({
    super.key,
    required this.exp,
  });

  final int? exp;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Exp ' + exp.toString() + ' Years',
      style: TextStyle(fontSize: 16.sp),
    );
  }
}

class DoctorRating extends StatelessWidget {
  const DoctorRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(Icons.star, color: Colors.yellow),
          Text(
            "4.0(10)",
            style: TextStyle(fontSize: 16.sp, color: Colors.black54),
          )
        ],
      ),
    );
  }
}

class DoctorFees extends StatelessWidget {
  const DoctorFees({
    super.key,
    required this.onlinefees,
    required this.onsitefees,
  });

  final int? onlinefees;
  final int? onsitefees;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Fees ${onlinefees}-${onsitefees}',
      style: TextStyle(fontSize: 17.sp, color: Colors.black87),
    );
  }
}

class QualificationName extends StatelessWidget {
  const QualificationName({
    super.key,
    required this.doctor,
  });

  final String doctor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          doctor,
          style: TextStyle(fontSize: 17.sp, color: Colors.black87),
        ),
      ],
    );
  }
}

class CategoryName extends StatelessWidget {
  const CategoryName({
    super.key,
    required this.doctorCat,
  });

  final doctorCat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        children: [
          Text(
            doctorCat,
            style: TextStyle(fontSize: 18.sp, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

class CardHeader extends StatelessWidget {
  const CardHeader({
    super.key,
    required this.doctorname,
  });

  final doctorname;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Image.asset(
          "assets/doctor_pic.png",
          height: 8.h,
        ),
        SizedBox(width: 3.w),
        Container(
          width: 45.w,
          child: Text(
            doctorname,
            maxLines: 3,
            style: TextStyle(
              color: Color(0xffFC9535),
              fontSize: 18.sp,
            ),
          ),
        ),
        Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(13),
          ),
          child: const Text(
            "Details",
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
