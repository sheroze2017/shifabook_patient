import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/userProfile.dart';

class UserProfileService extends GetxController {
  //RxList<dynamic> dataArray = <dynamic>[].obs;

  List<String> userProfile = [];
  List<String> userAllergies = [];
  List<String> userDisease = [];
  RxList<dynamic> userProfiles = [].obs;

  updatedata() async {
    //userProfiles.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userProfiles.addAll(prefs.getStringList('userData')!);
    userProfiles.add(prefs.getStringList('userDisease').toString());
    userProfiles.add(prefs.getStringList('userAllergies').toString());
    print(userProfiles);
  }

  fetchAndStoreProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? access_token = await prefs.getString('access_Token');

    UserProfile accountData;
    print(access_token);
    final url = Uri.parse(
        'http://3.80.54.173:4005/api/v1/patients/get-patient-profile');

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $access_token",
        },
      );
      if (response.statusCode == 200) {
        userAllergies.clear();
        userDisease.clear();
        userProfile.clear();
        //  userProfiles.clear();
        //  print(response.body);
        accountData = await UserProfile.fromJson(jsonDecode(response.body));
        var userData = await accountData.data;
        print(userData!.age);
        userProfile.insert(0, userData.fullName.toString());
        userProfile.insert(1, userData.mobile.toString());
        userProfile.insert(2, userData.email.toString());
        userProfile.insert(3, userData.gender.toString());
        userProfile.insert(4, userData.age.toString());
        userProfile.insert(5, userData.dob.toString());
        userProfile.insert(6, userData.age.toString());
        userProfile.insert(7, userData.userPatient!.bloodType.toString());
        userProfile.insert(8, userData.userPatient!.weight.toString());
        userProfile.insert(9, userData.userPatient!.height.toString());
        userProfile.insert(10, userData.cities![0].id.toString());
        userProfile.insert(11, userData.cities![0].name.toString());
        userDisease.insertAll(0, userData.userPatient!.disease!);
        userAllergies.insertAll(0, userData.userPatient!.allergies!);
        userProfiles.addAll(userProfile);
        prefs.setStringList('userData', userProfile);
        prefs.setStringList('userDisease', userDisease);
        prefs.setStringList('userAllergies', userAllergies);
        print('Data saved to local storage');
        print('User profile data saved to local storage');
      } else {
        print('API call failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching and storing API data: $error');
    }
  }

  Future<UserProfile> getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userProfileData = prefs.getString('userProfile');
    if (userProfileData != null) {
      return UserProfile.fromJson(jsonDecode(userProfileData));
    } else {
      throw Exception('User profile data not found');
    }
  }

  _showModal(context) {
    final userController = Get.put(UserProfileService());

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Full Name: ${userProfile[1]}"),
                //   Text("Mobile: ${userController.userProfi}"),
              ],
            ),
          ),
        );
      },
    );
  }
}
