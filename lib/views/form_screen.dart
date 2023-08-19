import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shifabook/controller/location/locationController.dart';
import 'package:shifabook/views/widgets/smallfield.dart';
import 'package:shifabook/views/widgets/textfield.dart';

import '../controller/user_authentication/form_controller.dart';

class formScreen extends StatefulWidget {
  const formScreen({super.key});

  @override
  State<formScreen> createState() => _formScreenState();
}

class _formScreenState extends State<formScreen> {
  //final controller = Get.put(LocationController());
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  TextEditingController _diseaseController = TextEditingController();
  TextEditingController _allergyController = TextEditingController();
  final TextEditingController _bloodtype = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  final TextEditingController _height = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  List<String> _selectedSkills = [];
  List<String> _selectedallergy = [];
  late String _selectedGender = 'male';
  final TextEditingController _yovdController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
  final patcontroller = Get.put(PatientController());
  //String selectedCity = ''; // Selected city name
  int selectedCityId = 0; // Selected city ID

  String? selectedCity;

  List<String> cities = [
    'Karachi',
    'Lahore',
    'Islamabad',
    'Quetta',
    'Peshawar',
  ];
  var maskFormatter = new MaskTextInputFormatter(
      mask: '####-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7f6fb),
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(top: 0, left: 24, right: 24, bottom: 20),
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 2.h,
              ),
              Text("Fill up form to proceed..",
                  style: GoogleFonts.lato(
                    letterSpacing: 4,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: 1.h,
              ),
              Container(
                width: 100.w,
                height: 16.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    color: Color.fromARGB(0, 229, 224, 224),
                    child: Image.asset(
                      'assets/doc.png',
                      scale: 2,
                    ),
                  ),
                ),
              ),
              // Text("Enter your details to proceed",
              //     style: GoogleFonts.lato(
              //       fontSize: 14,
              //       fontWeight: FontWeight.normal,
              //     )),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    //focusNode: f3,
                    onPressed: () {
                      setState(() {
                        _selectedGender = 'male';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _selectedGender == 'male' ? Colors.blue : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    child: Text(
                      'Male',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedGender = 'female';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedGender == 'female'
                          ? Colors.pink
                          : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    child: const Text(
                      'Female',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              // CustomTextFormField(
              //   focusNode: f1,
              //   controller: _nameController,
              //   labelText: 'Full Name',
              //   textInputAction: TextInputAction.next,
              //   onFieldSubmitted: (value) {
              //     f1.unfocus();
              //     FocusScope.of(context).requestFocus(f2);
              //   },
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Please enter the name';
              //     } else {
              //       return null;
              //     }
              //   },
              // ),
              // SizedBox(
              //   height: 2.h,
              // ),
              // CustomTextFormField(
              //   focusNode: f2,
              //   controller: _phoneController,
              //   labelText: 'Phone Number',
              //   textInputAction: TextInputAction.next,
              //   onFieldSubmitted: (value) {
              //     f2.unfocus();
              //     FocusScope.of(context).requestFocus(f3);
              //   },
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Please enter the number';
              //     } else {
              //       return null;
              //     }
              //   },
              // ),
              // SizedBox(
              //   height: 2.h,
              // ),
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
                controller: _dobController, // Controller for date of birth
                labelText: 'Date of Birth',
                hintText: 'YYYY-MM-DD',
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                  f7.unfocus();
                  FocusScope.of(context).requestFocus(f8);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Eenter Date of Birth';
                  } else {
                    final RegExp dateRegex = RegExp(
                        r'^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$');

                    if (!dateRegex.hasMatch(value)) {
                      return 'Enter a valid date\nin the format YYYY-MM-DD';
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
                  width: 80.h,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButton<String>(
                    hint: Text('City', style: TextStyle(color: Colors.black)),
                    value: selectedCity,
                    onChanged: (value) {
                      setState(() {
                        selectedCity = value.toString();
                        selectedCityId = cities.indexOf(value.toString()) + 1;
                        print(selectedCityId);
                      });
                    },
                    items: cities.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),

              // Container(
              //   height: 6.h,
              //   child: TextFormField(
              //     focusNode: f8,
              //     style: GoogleFonts.lato(
              //       fontSize: 14,
              //       fontWeight: FontWeight.w800,
              //     ),
              //     onChanged: (value) {
              //       print(value);
              //       print(c.entries);
              //       if (cityMap2
              //           .containsKey(_locationController.text.toLowerCase())) {
              //         print('find');
              //         print(value);
              //         selectedCityId =
              //             cityMap2[_locationController.text.toLowerCase()]!;
              //         //print('$cityName has a value of $cityValue');
              //       } else {
              //         // print('City not found in the map');
              //       }
              //     },
              //     controller: _locationController,
              //     decoration: InputDecoration(
              //       suffixIcon: IconButton(
              //           icon: Icon(Icons.location_on),
              //           onPressed: () async {
              //             //  await controller.getCurrentLocation();
              //             //  _locationController.text =
              //             //      await controller.currentLocation ?? '';
              //             if (cityMap2.containsKey(
              //                 _locationController.text.toLowerCase())) {
              //               print('find');
              //               selectedCityId = cityMap2[
              //                   _locationController.text.toLowerCase()]!;
              //             }
              //           }),
              //       contentPadding:
              //           EdgeInsets.only(left: 20, top: 10, bottom: 10),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(90.0)),
              //         // borderSide: BorderSide.none,
              //       ),
              //       filled: true,
              //       fillColor: Colors.grey[350],
              //       labelText: 'Location',
              //       hintStyle: GoogleFonts.lato(
              //         color: Colors.black26,
              //         fontSize: 18,
              //         fontWeight: FontWeight.w800,
              //       ),
              //     ),
              //     onFieldSubmitted: (value) {
              //       f8.unfocus();
              //       FocusScope.of(context).requestFocus(f9);
              //     },
              //     textInputAction: TextInputAction.next,
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return 'Please enter the location';
              //       } else if (selectedCityId == 0) {
              //         return 'Please enter Valid location';
              //       } else {
              //         return null;
              //       }
              //     },
              //   ),
              // ),

              SizedBox(
                height: 2.h,
              ),
              // CustomTextFormField(
              //   focusNode: f9,
              //   controller: _nationalityController,
              //   labelText: 'Nationality',
              //   textInputAction: TextInputAction.next,
              //   onFieldSubmitted: (value) {
              //     f8.unfocus();
              //     FocusScope.of(context).requestFocus(f9);
              //   },
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Please enter Nationality';
              //     } else {
              //       return null;
              //     }
              //   },
              // ),
              // SizedBox(
              //   height: 2.h,
              // ),
              CustomTextFormField(
                focusNode: f9,
                controller: _yovdController,
                labelText: 'How long visiting doctor',
                hintText: 'Eg: 3 month or 1 year',
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                  f9.unfocus();
                  FocusScope.of(context).requestFocus(f10);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter field';
                  } else {
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
                      borderRadius: BorderRadius.all(Radius.circular(90.0)),
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
                    hintText: 'Select Allergies you have',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(90.0)),
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
                  width: 100,
                  padding: const EdgeInsets.only(top: 25.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Obx(() {
                      if (patcontroller.isloading.value) {
                        return SpinKitWave(
                          color: Colors.indigo[900],
                          size: 9.w,
                        );
                      } else {
                        return ElevatedButton(
                          // focusNode: f10,
                          child: Text(
                            "Submit",
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            print('hi');
                            if (_formKey.currentState!.validate()) {
                              patcontroller.createPatientProfile(
                                  _bloodtype.text.toUpperCase(),
                                  _selectedallergy,
                                  _selectedSkills,
                                  selectedCityId,
                                  _weight.text,
                                  _height.text,
                                  _yovdController.text,
                                  _ageController.text,
                                  _selectedGender.toString(),
                                  _dobController.text);
                            }
                          },
                          //   showLoaderDialog(context);

                          //   _signInWithEmailAndPassword();
                          // }

                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.indigo[900],
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        );
                      }
                    }),
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
