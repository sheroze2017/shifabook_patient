import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifabook/views/widgets/smallfield.dart';
import 'package:shifabook/views/widgets/textfield.dart';

import '../controller/user_authentication/form_controller.dart';
import '../controller/user_authentication/update_controller.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  FocusNode f1 = new FocusNode();
  FocusNode f2 = new FocusNode();
  FocusNode f3 = new FocusNode();
  FocusNode f4 = new FocusNode();
  FocusNode f5 = new FocusNode();
  FocusNode f6 = new FocusNode();
  FocusNode f7 = new FocusNode();
  FocusNode f8 = new FocusNode();
  FocusNode f9 = new FocusNode();
  FocusNode f10 = new FocusNode();
  FocusNode f11 = new FocusNode();
  final Updatecontroller = Get.put(UpdatePofile());
  bool checkdata = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _dobController = TextEditingController();
  TextEditingController _diseaseController = TextEditingController();
  TextEditingController _allergyController = TextEditingController();
  final TextEditingController _bloodtype = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  final TextEditingController _height = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  List<dynamic> _selectedSkills = [];
  List<dynamic> _selectedallergy = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<dynamic> profile = [];
  final patcontroller = Get.put(PatientController());

  func() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic>? userdata = prefs.getStringList('userData');
    List<dynamic>? userdisease = prefs.getStringList('userDisease');
    List<dynamic>? userAllergies = prefs.getStringList('userAllergies');
    setState(() {
      _ageController.text = userdata![6].toString();
      _bloodtype.text = userdata[7].toString();
      _weight.text = userdata[8].toString();
      _height.text = userdata[9].toString();
      _dobController.text = userdata[5].toString();
      _selectedSkills.addAll(userdisease!);
      _selectedallergy.addAll(userAllergies!);
      profile.addAll(userdata);
    });
  }

  @override
  void dispose() {
    _ageController.dispose();
    _bloodtype.dispose();
    _weight.dispose();
    _height.dispose();
    _dobController.dispose();
    _selectedSkills.clear();
    _selectedallergy.clear();
    profile.clear();

    super.dispose();
  }

  @override
  void initState() {
    //availbility().updateAvailibility();
    // doctorProfileService().fetchAndStoreProfile();
    // landmark().fetchLandmarkNames(1);
    func();
    setState(() {
      checkdata = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black), // InkWell(
        //     onTap: () {
        //       Get.back();
        //     },
        //     child: Icon(Icons.arrow_back))
        // ]
      ),
      backgroundColor: Color(0xfff7f6fb),
      key: _scaffoldKey,
      body: checkdata
          ? Container()
          : Form(
              key: _formKey,
              child: Padding(
                padding:
                    EdgeInsets.only(top: 0, left: 24, right: 24, bottom: 20),
                child: SingleChildScrollView(
                  child: Column(children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    const Center(
                        child: Text(
                      'Profile Update',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3),
                    )),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text("Change the fields to Update",
                        style: GoogleFonts.lato(
                          letterSpacing: 4,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        )),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        smalltext(
                          typee: TextInputType.number,
                          focusNode: f3,
                          controller: _ageController,
                          labelText: 'Age',
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {
                            f3.unfocus();
                            FocusScope.of(context).requestFocus(f4);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the Age';
                            } else {
                              return null;
                            }
                          },
                        ),
                        smalltext(
                          focusNode: f4,
                          controller: _bloodtype,
                          labelText: 'BloodType',
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {
                            f4.unfocus();
                            FocusScope.of(context).requestFocus(f5);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the blood type';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        smalltext(
                          typee: TextInputType.number,
                          focusNode: f5,
                          controller: _weight,
                          labelText: 'Weight Kg',
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {
                            f5.unfocus();
                            FocusScope.of(context).requestFocus(f6);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the Weight';
                            } else {
                              return null;
                            }
                          },
                        ),
                        smalltext(
                          typee: TextInputType.number,
                          focusNode: f6,
                          controller: _height,
                          labelText: 'Height cm',
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {
                            f6.unfocus();
                            FocusScope.of(context).requestFocus(f7);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the height';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    CustomTextFormField(
                      focusNode: f7,
                      controller:
                          _dobController, // Controller for date of birth
                      labelText: 'Date of Birth',
                      hintText: 'YYYY-MM-DD',
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        f7.unfocus();
                        FocusScope.of(context).requestFocus(f8);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Date of Birth';
                        } else {
                          final RegExp dateRegex = RegExp(
                              r'^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$');

                          if (!dateRegex.hasMatch(value)) {
                            return 'Please enter a valid date\nin the format YYYY-MM-DD';
                          }

                          // Additional validation logic if needed
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      height: 6.h,
                      child: TextFormField(
                        focusNode: f10,
                        decoration: InputDecoration(
                          labelText: 'Disease',
                          hintText: 'Select disease you have',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                          ),
                          filled: true,
                          fillColor: Colors.grey[350],
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {
                          // Do nothing
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            if (value.isNotEmpty) {
                              _selectedSkills.add(value.toString());
                              _diseaseController.clear();
                              //f10.requestFocus();
                            }
                          });
                          FocusScope.of(context).requestFocus(f10);
                        },
                        inputFormatters: [],
                        controller: _diseaseController,
                        // controller: TextEditingController(
                        //   text: _selectedSkills.join(', '),
                        // ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Wrap(
                      spacing: 8.0,
                      children: _selectedSkills
                          .map(
                            (skill) => InputChip(
                              label: Text(skill),
                              onDeleted: () {
                                setState(() {
                                  _selectedSkills.remove(skill);
                                });
                              },
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      height: 6.h,
                      child: TextFormField(
                        focusNode: f11,
                        decoration: InputDecoration(
                          labelText: 'Allergies',
                          hintText: 'Select Allergy you have',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                          ),
                          filled: true,
                          fillColor: Colors.grey[350],
                        ),

                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {
                          // Do nothing
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            if (value.isNotEmpty) {
                              _selectedallergy.add(value.toString());
                              _allergyController.clear();
                              // f11.requestFocus();
                            }
                          });
                          FocusScope.of(context).requestFocus(f11);
                        },
                        inputFormatters: [],
                        controller: _allergyController,
                        // controller: TextEditingController(
                        //   text: _selectedSkills.join(', '),
                        // ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Wrap(
                      spacing: 8.0,
                      children: _selectedallergy
                          .map(
                            (skill) => InputChip(
                              label: Text(skill),
                              onDeleted: () {
                                setState(() {
                                  _selectedallergy.remove(skill);
                                });
                              },
                            ),
                          )
                          .toList(),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: SizedBox(
                        width: 40.w,
                        height: 5.h,
                        child: ElevatedButton(
                          // focusNode: f3,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await UpdatePofile().updatePatientProfile(
                                  profile[0].toString(),
                                  _ageController.text.toString(),
                                  _selectedallergy,
                                  _selectedSkills,
                                  profile[10].toString(),
                                  _weight.text.toString(),
                                  _height.text.toString());
                            }
                          },

                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xffFBB97C),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          // focusNode: f3,
                          child: Obx(
                            () {
                              if (Updatecontroller.isloading.value) {
                                return SpinKitWave(
                                  color: Colors.white,
                                  size: 6.w,
                                );
                              } else {
                                return Text(
                                  "Update",
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
    );
  }
}
