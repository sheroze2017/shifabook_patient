import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifabook/views/login_screen.dart';

import '../../views/home.dart';
import '../userData/userInfo.dart';

class PatientController extends GetxController {
  var isloading = false.obs;

  Future<void> createPatientProfile(
      String blood,
      List allergy,
      List disease,
      int id,
      String weight,
      String height,
      String visitinghistory,
      String age,
      String gender,
      String dob) async {
    isloading.value = true;
    print('hi');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? access_token = await prefs.getString('access_Token');
    print(access_token);
    String url =
        'http://3.80.54.173:4005/api/v1/patients/create-patient-profile';
    try {
      final body = {
        "blood_type": blood,
        "allergies": allergy,
        "disease": disease,
        "city_id": id,
        "weight": "${weight}kg",
        "height": "${height}cm",
        "since_visit": visitinghistory,
        "age": age,
        "gender": gender,
        "dob": dob
      };

      final response = await http.post(
        Uri.parse(url as String),
        headers: {
          "Authorization": "Bearer $access_token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );
      // final response = await http.post(url, body: body, headers: header);

      if (response.statusCode == 200) {
        print("result success");
        // Success
        await prefs.setString('blood_type', blood);
        await prefs.setString('allergies', allergy.toString());
        await prefs.setString('disease', disease.toString());
        await prefs.setInt('city_id', id);
        await prefs.setString('weight', weight.toString());
        await prefs.setString('visitinghistory', visitinghistory.toString());
        await prefs.setString('age', age.toString());
        await prefs.setString('dob', dob.toString());
        await prefs.setString('gender', gender.toString());

        Get.snackbar('Message', 'User data saved');
        await UserProfileService().fetchAndStoreProfile();

        Get.to(HomePage());

        print('Patient profile created successfully.');
      } else {
        // Handle error
        Get.snackbar('Error', 'Invalid Input');
        print(response.body);
        print(
            'Failed to create patient profile. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      print('Error creating patient profile: $e');
    } finally {
      isloading.value = false;
    }
  }
}
