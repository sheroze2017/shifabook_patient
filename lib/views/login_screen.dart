import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shifabook/views/home.dart';
import 'package:shifabook/views/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/user_authentication/login_controller.dart';
import 'form_screen.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: "+923000000009");
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _passwordController =
      TextEditingController(text: '123456');

  FocusNode f1 = new FocusNode();
  FocusNode f2 = new FocusNode();
  FocusNode f3 = new FocusNode();
  final controller = Get.put(LoginController());
  var maskFormatter = new MaskTextInputFormatter(
      mask: '+92##########',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7f6fb),
      key: _scaffoldKey,
      body: Builder(builder: (BuildContext context) {
        return SafeArea(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return false;
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: withEmailPassword(),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget withEmailPassword() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(right: 8, left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                'assets/mainlogo.png',
                scale: 2,
              ),
            ),
            Container(
              height: 40.h,
              width: 90.w,
              decoration: BoxDecoration(
                color: Color(0xfff7f6fb),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Login',
                      style: GoogleFonts.lato(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextFormField(
                      inputFormatters: [maskFormatter],
                      focusNode: f1,
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                      keyboardType: TextInputType.phone,
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Phone No',
                        hintText: '+923000000000',
                        contentPadding:
                            EdgeInsets.only(left: 20, top: 10, bottom: 10),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(90.0),
                            ),
                            borderSide:
                                BorderSide(color: Colors.indigo, width: 2)),
                        filled: true,
                        fillColor: Colors.grey[350],
                        //hintText: 'Email',
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
                        if (value!.isEmpty) {
                          return 'Please enter Number';
                        }
                        RegExp pakistanNumberRegex = RegExp(r'^\+923\d{9}$');
                        if (!pakistanNumberRegex.hasMatch(value)) {
                          return 'Please enter a valid Pakistan phone number (+923xxxxxxxxx)';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextFormField(
                      focusNode: f2,
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                      //keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        //border: OutlineInputBorder(),
                        labelText: 'Password',
                        contentPadding:
                            EdgeInsets.only(left: 20, top: 10, bottom: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                          // borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[350],
                        hintText: 'Password',
                        hintStyle: GoogleFonts.lato(
                          color: Colors.black26,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        f2.unfocus();
                        FocusScope.of(context).requestFocus(f3);
                      },
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value!.isEmpty) return 'Please enter the Passord';
                        return null;
                      },
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          // width: 50.w,
                          // height: 6.h,
                          height: 8.h,
                          width: 8.h,
                          child: Obx(() {
                            if (controller.isloading.value == true) {
                              return SpinKitFadingCube(
                                color: Colors.indigo[900],
                                size: 10.w,
                              );
                            } else {
                              return ElevatedButton(
                                  focusNode: f3,
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      print(_emailController.text);
                                      print(_passwordController.text);
                                      await controller.login(
                                          _emailController.text,
                                          _passwordController.text);
                                    }
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
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ));
                            }
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: TextButton(
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(Colors.transparent)),
                onPressed: () {},
                child: Text(
                  'Forgot Password?',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: GoogleFonts.lato(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      onPressed: () => _pushPage(context, Register()),
                      child: Text(
                        'Signup here',
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
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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

  void _signInWithEmailAndPassword() async {
    // try {
    //   final User user = (await _auth.signInWithEmailAndPassword(
    //     email: _emailController.text,
    //     password: _passwordController.text,
    //  ))
    //       .user;
    //   if (!user.emailVerified) {
    //     await user.sendEmailVerification();
    //   }
    //   Navigator.of(context)
    //       .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    // } catch (e) {
    //   final snackBar = SnackBar(
    //     content: Row(
    //       children: [
    //         Icon(
    //           Icons.info_outline,
    //           color: Colors.white,
    //         ),
    //         Text(" There was a problem signing you in"),
    //       ],
    //     ),
    //   );
    //   Navigator.pop(context);
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // }
  }

  void _pushPage(BuildContext context, Widget page) {
    Get.to(page, transition: Transition.upToDown);
  }
}
