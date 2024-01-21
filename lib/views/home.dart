import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifabook/controller/userData/userInfo.dart';
import 'package:shifabook/data/data.dart';
import 'package:shifabook/model/speciality.dart';
import 'package:shifabook/views/DoctorInfo/doctor_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shifabook/views/news_Screen.dart';
import 'package:shifabook/views/widgets/appbar.dart';

import '../controller/doctorData/doctorCategoryController.dart';
import '../model/doctorCategory.dart';
import 'DoctorInfo/CategoryDoctor.dart';

String selectedCategorie = "Adults";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool checkdata = false;
  late List<String?> userdata;
  // late List<String?> userallergies;
  // late List<String?> userdisease;

  // String? _address;
  // String? bloodType;
  // // List<String>? allergies;
  // List<String>? diseases;
  // String? weight;
  // String? visitingHistory;
  // String? fullName;
  // String? userId;
  // String? email;
  // String? mobile;
  // String? isActive;
  // String? isVerify;
  // String? createdAt;
  // String? updatedAt;
  // String? roleName;
  // String? roleId;
  // String? accessToken;
  // String? refreshToken;
  @override
  void initState() {
    super.initState();
    specialities = getSpeciality();
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
    setState(() {
      userdata = prefs.getStringList('userData')!;
    });
  }

  List<String> categories = ["Adults", "Childrens", "Womens", "Mens"];
  late List<SpecialityModel> specialities;
  List<String> imageList = [
    'https://merriam-webster.com/assets/mw/images/article/art-wap-article-main/alt-5d4c7e7746fb1-6705-68b432d17a9a6f2e77528cfff3a63a82@1x.jpg',
    'https://merriam-webster.com/assets/mw/images/article/art-wap-article-main/alt-5d4c7e7746fb1-6705-68b432d17a9a6f2e77528cfff3a63a82@1x.jpg',
    'https://merriam-webster.com/assets/mw/images/article/art-wap-article-main/alt-5d4c7e7746fb1-6705-68b432d17a9a6f2e77528cfff3a63a82@1x.jpg',
  ];

  final List<Map<String, dynamic>> doctorStatic = [
    {
      "full_name": "testDoctor11",
      "image": null,
      "doctor_user": {
        "id": 3,
        "affilation": ["Aga khan Hospital", "ABD"],
        "qualification": ["MBBS", "MBA"],
        "years_of_experience": 9,
        "onsite_consultation_fee": 1000,
        "online_consultation_fee": 500
      },
      "doctor_availability": {
        "availability": [
          {
            "Day": "Thursday",
            "times": [
              {"end_time": "10:00", "start_time": "7:00"}
            ],
            "landmark_id": 3
          },
          {
            "Day": "Friday",
            "times": [
              {"end_time": "10:00", "start_time": "7:00"}
            ],
            "landmark_id": 3
          }
        ]
      }
    },
    {
      "full_name": "Dr Hussain ",
      "image": null,
      "doctor_user": {
        "id": 7,
        "affilation": ["Imam clinic"],
        "qualification": ["Developer", "stackweaver"],
        "years_of_experience": 3,
        "onsite_consultation_fee": 1000,
        "online_consultation_fee": 2000
      },
      "doctor_availability": {
        "availability": [
          {
            "Day": "Wednesday",
            "times": [
              {"end_time": "14:00", "start_time": "8:00"}
            ],
            "landmark_id": 1
          },
          {
            "Day": "Thursday",
            "times": [
              {"end_time": "14:00", "start_time": "8:00"}
            ],
            "landmark_id": 1
          }
        ]
      }
    }
  ];

  @override
  Widget build(BuildContext context) {
    DateTime? _lastPressedAt;
    final doctorController = Get.put(DoctorData());
    Future<bool> onWillPop() async {
      DateTime now = DateTime.now();
      if (_lastPressedAt == null ||
          now.difference(_lastPressedAt!) > Duration(seconds: 2)) {
        _lastPressedAt = now;
        Get.snackbar('Message', 'Tap again to exit',
            duration: Duration(seconds: 2),
            backgroundColor: Colors.white,
            colorText: Colors.black);
        return Future.value(false);
      }
      SystemNavigator.pop();

      return Future.value(true);
    }

    return SafeArea(
        child: Scaffold(
            drawer: NavigationDrawer1(),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.black87),
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              actions: [
                IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: () async {
                    // DoctorData().fetchDoctors(1);
                    showModal(context);

                    // Get.to(FitnessArticlesPage());
                    // Open user profile page
                    // Add your navigation logic here
                  },
                ),
              ],
            ),
            body: checkdata
                ? Center(
                    child: SpinKitFadingCube(
                    color: Colors.indigo[900],
                    size: 12.w,
                  ))
                : GestureDetector(
                    onTap: () => SystemChrome.setEnabledSystemUIMode(
                        SystemUiMode.immersiveSticky),
                    child: WillPopScope(
                      onWillPop: onWillPop,
                      child: SingleChildScrollView(
                        child: Container(
                          color: Colors.white,
                          // padding: EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                    height: 20.h,

                                    // enlargeCenterPage: true,
                                    autoPlay: true,
                                    aspectRatio: 16 / 9,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enableInfiniteScroll: true,
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                    viewportFraction: 1,
                                  ),
                                  items: imageList.map((imageUrl) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                          ),
                                          child: Image.asset(
                                            'assets/homeslider.png',
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  //width: 90.w,
                                  height: 5.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Color.fromARGB(0, 204, 201, 201),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () =>
                                            Get.to(FitnessArticlesPage()),
                                        child: Text(
                                          'Health Article ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        ),
                                      ),
                                      Row(
                                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.notifications,
                                            size: 20.0,
                                          ),
                                          // SizedBox(
                                          //   width: 10.w,
                                          // ),
                                          // Icon(
                                          //   Icons.calendar_today,
                                          //   size: 20.0,
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(
                                  "Categories",
                                  style: TextStyle(
                                      color: Colors.black87.withOpacity(0.8),
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 2, 12, 2),
                                child: SizedBox(
                                  height: 17.h,
                                  child: ListView.builder(
                                      itemCount: specialities.length,
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () async {
                                            await doctorController
                                                .fetchDoctors(index + 1);
                                            Get.to(CategoryDoctor(),
                                                arguments: {
                                                  'category':
                                                      specialities[index]
                                                          .speciality as String
                                                });
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8),
                                            child: SpecialistTile(
                                              imgAssetPath: specialities[index]
                                                  .imgAssetPath as String,
                                              speciality: specialities[index]
                                                  .speciality as String,
                                              noOfDoctors: specialities[index]
                                                  .noOfDoctors as int,
                                              backColor: specialities[index]
                                                  .backgroundColor as Color,
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                              Divider(),
                              SizedBox(
                                height: 2.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Doctors",
                                  style: TextStyle(
                                      color: Colors.black87.withOpacity(0.8),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 2, 12, 2),
                                child: SizedBox(
                                  child: ListView.builder(
                                    itemCount: doctorStatic.length,
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      final doctorname =
                                          doctorStatic[index]['full_name'];
                                      //   final img =do [index];
                                      // var doctor =
                                      //     doctorController.doctors[index];
                                      var exp = doctorStatic[index]
                                              ['doctor_user']
                                          ['years_of_experience'];
                                      var onlinefees = doctorStatic[index]
                                              ['doctor_user']
                                          ['online_consultation_fee'];
                                      var onsitefees = doctorStatic[index]
                                              ['doctor_user']
                                          ['onsite_consultation_fee'];
                                      List<String> qual = doctorStatic[index]
                                          ['doctor_user']['qualification'];
                                      return GestureDetector(
                                        onTap: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) => DoctorsInfo(doctorname,
                                          //         img, doctor, doctorCat, exp, avail),
                                          //   ),
                                          // );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10, bottom: 6),
                                          child: Container(
                                            height: 20.h,
                                            decoration: BoxDecoration(
                                              color: Color(0xffFFEEE0),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 14, vertical: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
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
                                                        color:
                                                            Color(0xffFC9535),
                                                        fontSize: 18.sp,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 0.5.h,
                                                    ),
                                                    Text(
                                                      'General Physician',
                                                      style: TextStyle(
                                                          fontSize: 16.sp),
                                                    ),
                                                    SizedBox(
                                                      height: 0.5.h,
                                                    ),
                                                    Text(
                                                      qual.join(' '),
                                                      style: TextStyle(
                                                          fontSize: 16.sp),
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
                                                      style: TextStyle(
                                                          fontSize: 16.sp),
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Text(
                                                      'Experience ' +
                                                          exp.toString() +
                                                          ' Years',
                                                      style: TextStyle(
                                                          fontSize: 16.sp),
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
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15,
                                                          vertical: 9),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffFBB97C),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(13),
                                                      ),
                                                      child: const Text(
                                                        "Details",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                      );
                                    },
                                  ),
                                ),

                                // DoctorsTile(),
                                // DoctorsTile(),
                                // DoctorsTile(),
                                // DoctorsTile(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )));
  }

  showModal(context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber),
                  borderRadius: BorderRadius.circular(20)),
              height: 22.h,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25.sp,
                      backgroundImage: NetworkImage(
                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg'),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Details',
                            style: TextStyle(
                                fontSize: 22.sp,
                                color: Colors.black,
                                letterSpacing: 3,
                                fontWeight: FontWeight.bold)),
                        Text(userdata[0]!,
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.black,
                                letterSpacing: 3)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Ph: ' + userdata[1]!,
                            style: TextStyle(fontSize: 14, color: Colors.black))
                      ],
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}

class CategorieTile extends StatefulWidget {
  final String categorie;
  final bool isSelected;
  _HomePageState context;
  CategorieTile(
      {required this.categorie,
      required this.isSelected,
      required this.context});

  @override
  _CategorieTileState createState() => _CategorieTileState();
}

class _CategorieTileState extends State<CategorieTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.context.setState(() {
          selectedCategorie = widget.categorie;
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(left: 8),
        height: 30,
        decoration: BoxDecoration(
            color: widget.isSelected ? Color(0xffFFD0AA) : Colors.white,
            borderRadius: BorderRadius.circular(30)),
        child: Text(
          widget.categorie,
          style: TextStyle(
              color: widget.isSelected ? Color(0xffFC9535) : Color(0xffA1A1A1)),
        ),
      ),
    );
  }
}

class SpecialistTile extends StatelessWidget {
  final String imgAssetPath;
  final String speciality;
  final int noOfDoctors;
  final Color backColor;
  SpecialistTile(
      {required this.imgAssetPath,
      required this.speciality,
      required this.noOfDoctors,
      required this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.w,
      height: 20.w,
      margin: const EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
          color: backColor, borderRadius: BorderRadius.circular(24)),
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            speciality,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          SizedBox(
            height: 0.5.h,
          ),
          Image.asset(
            imgAssetPath,
            height: 10.h,
            fit: BoxFit.fitHeight,
          )
        ],
      ),
    );
  }
}

// class DoctorsTile extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => DoctorsInfo()));
//       },
//       child: Padding(
//         padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 6),
//         child: Container(
//           height: 12.h,
//           decoration: BoxDecoration(
//               color: Color(0xffFFEEE0),
//               borderRadius: BorderRadius.circular(15)),
//           padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//           child: Row(
//             children: <Widget>[
//               Image.asset(
//                 "assets/doctor_pic.png",
//                 height: 8.h,
//               ),
//               SizedBox(width: 3.w),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                     "Dr. Stefeni Albert",
//                     style: TextStyle(color: Color(0xffFC9535), fontSize: 12),
//                   ),
//                   SizedBox(
//                     height: 0.5.h,
//                   ),
//                   Text(
//                     "Heart Speailist",
//                     style: TextStyle(fontSize: 9),
//                   )
//                 ],
//               ),
//               Spacer(),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 15, vertical: 9),
//                 decoration: BoxDecoration(
//                     color: Color(0xffFBB97C),
//                     borderRadius: BorderRadius.circular(13)),
//                 child: Text(
//                   "Call",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 13,
//                       fontWeight: FontWeight.w500),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

