import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifabook/model/userProfile.dart';
import 'package:shifabook/views/ProfileScreen.dart';

import 'package:shifabook/views/home.dart';
import 'package:shifabook/views/updateScreen.dart';
import 'package:shifabook/views/widgets/drawer.dart';
import 'package:http/http.dart' as http;
import '../../controller/userData/userInfo.dart';
import '../../controller/user_authentication/login_controller.dart';
import '../login_screen.dart';

class NavigationDrawer1 extends StatelessWidget {
  final lcontroller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        // color: Color.fromARGB(255, 209, 206, 206),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xffFBB97C), Color(0xffFC9535)],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 40, 24, 0),
                child: Column(
                  children: [
                    headerWidget(),
                    SizedBox(
                      height: 1.h,
                    ),
                    Divider(
                      thickness: 1,
                      height: 10,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    // DrawerItem(
                    //   name: 'People',
                    //   icon: Icons.people,
                    //   onPressed: () => onItemPressed(context, index: 0),
                    // ),
                    // const SizedBox(
                    //   height: 30,
                    // ),
                    DrawerItem(
                        name: 'Profile',
                        icon: Icons.account_box_rounded,
                        onPressed: () => onItemPressed(context, index: 0)),
                    const SizedBox(
                      height: 30,
                    ),
                    // DrawerItem(
                    //     name: 'Chats',
                    //     icon: Icons.message_outlined,
                    //     onPressed: () => onItemPressed(context, index: 2)),
                    // const SizedBox(
                    //   height: 30,
                    // ),
                    // DrawerItem(
                    //     name: 'Favourites',
                    //     icon: Icons.favorite_outline,
                    //     onPressed: () => onItemPressed(context, index: 3)),
                    // const SizedBox(
                    //   height: 30,
                    // ),
                    const Divider(
                      thickness: 1,
                      height: 10,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    DrawerItem(
                        name: 'Update',
                        icon: Icons.settings,
                        onPressed: () => onItemPressed(context, index: 4)),
                    const SizedBox(
                      height: 30,
                    ),
                    DrawerItem(
                        name: 'Log out',
                        icon: Icons.logout,
                        onPressed: () => onItemPressed(context, index: 5)),
                  ],
                ),
              ),
            ),
            Obx(() {
              if (lcontroller.logoutLoader.value) {
                return LoadingDialog();
              } else {
                return Container();
              }
            })
          ],
        ),
      ),
    );
  }

  logout() async {
    print('click');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? refreshtoken = prefs.getString('refresh_Token');
    String? access_token = prefs.getString('access_Token');

    final body = {"refresh_token": refreshtoken.toString()};
    try {
      var url = Uri.parse('http://3.80.54.173:4005/api/v1/users/logout');
      var response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $access_token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        prefs.clear();
        Get.offAll(SignIn(), transition: Transition.fade);
        // Future.delayed(Duration(seconds: 2));
        print('clear data');
      } else {
        Future.delayed(Duration(seconds: 5))
            .then((value) => lcontroller.logoutLoader.value = false);
      }
    } catch (error) {
      print(error);
      // LoginController().logoutLoader.value = false;
    } finally {
      lcontroller.logoutLoader.value = false;
    }
  }

  void onItemPressed(BuildContext context, {required int index}) {
    // Navigator.pop(context);

    switch (index) {
      case 0:
        Get.to(
          UserProfileScreen(),
          transition: Transition.native, // Use native transition
          duration: Duration(milliseconds: 300),
        );

        break;
      case 4:
        Get.to(
          UpdateScreen(),
          transition: Transition.native, // Use native transition
          duration: Duration(milliseconds: 300),
        );
        break;
      case 5:
        lcontroller.logoutLoader.value = true;
        logout();
    }
  }

  Widget headerWidget() {
    const url =
        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg';
    return Row(
      children: [
        CircleAvatar(
          radius: 30.sp,
          backgroundImage: NetworkImage(url),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Shifabook',
                style: TextStyle(
                    fontSize: 20.sp, color: Colors.white, letterSpacing: 3)),
            // SizedBox(
            //   height: 10,
            // ),
            // Text('sheroze2017@gmail.com',
            //     style: TextStyle(fontSize: 14, color: Colors.white))
          ],
        )
      ],
    );
  }
}

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(
            color: Color(0xffFBB97C),
            strokeWidth: 2,
          ),
          SizedBox(width: 16),
          Text(
            'Logging Out...',
            style: TextStyle(fontSize: 17.sp),
          ),
        ],
      ),
    );
  }
}
