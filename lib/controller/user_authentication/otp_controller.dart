import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shifabook/views/login_screen.dart';
import 'package:shifabook/Global.dart';

import 'dart:convert';

import 'package:shifabook/views/otps_screen2.dart';

class OTPController extends GetxController {
  Future<void> checkUser(String mobile) async {
    String url = await '$baseUrl/users/check';
    String nmo = await mobile;
    Map<String, dynamic> requestBody = await {
      'mobile': nmo,
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        // var jsonResponse = json.decode(response.body);
        //bool status = await jsonResponse['status'];
        // String message = await jsonResponse['message'];
        await Get.snackbar('Success', 'Pin has been sent');
        await Get.to(Otp(), arguments: [nmo]);
        // ...
      } else if (response.statusCode == 409) {
        //  var jsonResponse = json.decode(response.body);
        // String message = jsonResponse['message'];
        // String error = jsonResponse['error'];
        // Handle the response data according to your requirements
        await Get.snackbar('Error', 'User Verified or Already Exist');
        // ...
      } else if (response.statusCode == 404) {
        var jsonResponse = json.decode(response.body);
        String message = jsonResponse['message'];
        String error = jsonResponse['error'];
        await Get.snackbar('Error', "User does not exist, Please sign up");
      } else {
        // Handle other error cases
        // ...
      }
    } catch (error) {
      // Handle network or API call errors
      // ...
    }
  }

  Future<void> VerifyUser(String mobile, String pin) async {
    String url = '$baseUrl/users/verify';

    Map<String, dynamic> requestBody = {
      'mobile': mobile,
      'pin': pin,
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        bool status = await jsonResponse['status'];
        String message = await jsonResponse['message'];
        Get.snackbar('Success', 'Pin Match');

        Future.delayed(Duration(seconds: 2)).then((value) {
          Get.offAll(SignIn(), transition: Transition.native);
        });
      } else if (response.statusCode == 404) {
        var jsonResponse = json.decode(response.body);
        String message = jsonResponse['message'];
        String error = jsonResponse['error'];
        await Get.snackbar('Error', 'Incorret Pin');

        // Handle the response data according to your requirements
        // ...
      } else {
        // Handle other error cases
        // ...
      }
    } catch (error) {
      // Handle network or API call errors
      // ...
    }
  }
}
