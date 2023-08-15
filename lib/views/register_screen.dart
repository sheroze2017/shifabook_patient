import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shifabook/controller/user_authentication/signup_controller.dart';
import 'package:shifabook/views/otp_screen.dart';

import 'login_screen.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayName = TextEditingController();

  final TextEditingController _numController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final controller = Get.put(signupController());

  FocusNode f1 = new FocusNode();
  FocusNode f2 = new FocusNode();
  FocusNode f3 = new FocusNode();
  FocusNode f4 = new FocusNode();
  FocusNode f5 = new FocusNode();

  late bool _isSuccess;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7f6fb),
      body: Padding(
        padding: const EdgeInsets.only(top: 25.0, right: 15, left: 15),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 2.h,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                                onTap: () => Get.back(),
                                child: const Icon(Icons.arrow_back_ios))),
                        Image.asset(
                          'assets/regicon.png',
                          scale: 8,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          'Sign up',
                          style: GoogleFonts.lato(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        TextFormField(
                          focusNode: f1,
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: _displayName,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                left: 20, top: 10, bottom: 10),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              // borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[350],
                            labelText: 'Name',
                            hintText: 'Name',
                            hintStyle: GoogleFonts.lato(
                              color: Colors.black26,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          onFieldSubmitted: (value) {
                            f1.unfocus();
                            FocusScope.of(context).requestFocus(f2);
                          },
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) return 'Please enter the Name';
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        TextFormField(
                          focusNode: f2,
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 20, top: 10, bottom: 10),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              // borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[350],
                            labelText: 'Email',
                            hintStyle: GoogleFonts.lato(
                              color: Colors.black26,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          onFieldSubmitted: (value) {
                            //f2.unfocus();
                            FocusScope.of(context).requestFocus(f3);
                          },
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Email';
                            }
                            // else if (!emailValidate(value)) {
                            //   return 'Please enter correct Email';
                            // }
                            // return null;
                          },
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        TextFormField(
                          focusNode: f3,
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                          //  keyboardType: TextInputType.,
                          //keyboardType: TextInputType.phone,
                          controller: _numController,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 20, top: 10, bottom: 10),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              // borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[350],
                            labelText: 'Phone No',
                            hintText: 'Eg: +92300000001',
                            hintStyle: GoogleFonts.lato(
                              color: Colors.black26,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          onFieldSubmitted: (value) {
                            // f3.unfocus();
                            //  if (_passwordController.text.isEmpty) {
                            FocusScope.of(context).requestFocus(f4);
                            // }
                          },
                          // textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Number';
                            }
                            RegExp pakistanNumberRegex =
                                RegExp(r'^\+923\d{9}$');

                            if (!pakistanNumberRegex.hasMatch(value)) {
                              return 'Please enter a valid Pakistan\nphone number (+923xxxxxxxxx)';
                            }
                            // else if (!emailValidate(value)) {
                            //   return 'Please enter correct Number';
                            // }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        TextFormField(
                          focusNode: f4,
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                          //keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 20, top: 10, bottom: 10),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              // borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[350],
                            labelText: 'Password',
                            hintStyle: GoogleFonts.lato(
                              color: Colors.black26,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          onFieldSubmitted: (value) {
                            f4.unfocus();
                            if (_passwordConfirmController.text.isEmpty) {
                              FocusScope.of(context).requestFocus(f5);
                            }
                          },
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        TextFormField(
                          focusNode: f5,
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                          controller: _passwordConfirmController,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 20, top: 10, bottom: 10),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              // borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[350],
                            labelText: 'Confirm Password',
                            hintStyle: GoogleFonts.lato(
                              color: Colors.black26,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          onFieldSubmitted: (value) {
                            f5.unfocus();
                          },
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Password';
                            } else if (value
                                    .compareTo(_passwordController.text) !=
                                0) {
                              return 'Password not Matching';
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                        ),
                        Obx(() {
                          if (controller.isLoading.value == true) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 25.0, right: 25.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: SpinKitFadingCube(
                                  color: Colors.indigo[900],
                                  size: 10.w,
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              padding:
                                  const EdgeInsets.only(top: 25.0, right: 25),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  // width: 50.w,
                                  // height: 6.h,
                                  height: 8.h,
                                  width: 8.h,
                                  child: ElevatedButton(
                                      focusNode: f3,
                                      onPressed: () async {
                                        //controller.isLoading.value = true;
                                        //  print(controller.userData.value.mobile);
                                        if (_formKey.currentState!.validate()) {
                                          await controller.signup(
                                              _displayName.text,
                                              _passwordConfirmController.text,
                                              _numController.text);
                                        }
                                        //   Get.to(otpmobile(), arguments: [
                                        //     _displayName.text,
                                        //     _numController.text,
                                        //   ]);
                                        // }
                                      },
                                      // if (_formKey.currentState.validate()) {
                                      //   showLoaderDialog(context);
                                      //   _signInWithEmailAndPassword();
                                      // }
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.indigo[900],
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            );
                          }
                        }),
                        Container(
                          padding:
                              EdgeInsets.only(top: 25, left: 10, right: 10),
                          width: MediaQuery.of(context).size.width,
                          child: Divider(
                            thickness: 1.5,
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: GoogleFonts.lato(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent)),
                                  onPressed: () => _pushPage(context, SignIn()),
                                  child: Text(
                                    'Sign in',
                                    style: GoogleFonts.lato(
                                      fontSize: 15,
                                      color: Colors.indigo[700],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }

  // Widget _signUp() {
  //   return
  // }

  showAlertDialog(BuildContext context) {
    Navigator.pop(context);
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: GoogleFonts.lato(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pop(context);
        FocusScope.of(context).requestFocus(f2);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Error!",
        style: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "Email already Exists",
        style: GoogleFonts.lato(),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 15), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // bool emailValidate(String email) {
  //   if (RegExp(
  //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
  //       .hasMatch(email)) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  void _registerAccount() async {
    // User user;
    // UserCredential credential;

    // try {
    //   credential = await _auth.createUserWithEmailAndPassword(
    //     email: _emailController.text,
    //     password: _passwordController.text,
    //   );
    // } catch (error) {
    //   if (error.toString().compareTo(
    //           '[firebase_auth/email-already-in-use] The email address is already in use by another account.') ==
    //       0) {
    //     showAlertDialog(context);
    //     print(
    //         "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    //     print(user);
    //   }
    // }
    // user = credential.user;

    // if (user != null) {
    //   if (!user.emailVerified) {
    //     await user.sendEmailVerification();
    //   }
    //   await user.updateProfile(displayName: _displayName.text);

    //   FirebaseFirestore.instance.collection('users').doc(user.uid).set({
    //     'name': _displayName.text,
    //     'birthDate': null,
    //     'email': user.email,
    //     'phone': null,
    //     'bio': null,
    //     'city': null,
    //   }, SetOptions(merge: true));

    //   Navigator.of(context)
    //       .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    // } else {
    //   _isSuccess = false;
    // }
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}
