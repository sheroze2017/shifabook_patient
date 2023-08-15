import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifabook/model/signup_model.dart';

import '../../views/otp_screen.dart';

class signupController extends GetxController {
  var isLoading = false.obs;
  RxString errorMessage = ''.obs;

  Future<void> signup(String fullname, String password, String mobileno) async {
    // isLoading.value = true;
    errorMessage.value = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String url = 'http://3.80.54.173:4005/api/v1/users/signup';

    Map<String, dynamic> requestBody = {
      'full_name': fullname,
      'password': password,
      'mobile': mobileno,
      'type': 1,
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );
      print(response.body);
      if (response.statusCode == 201) {
        final responseData = await json.decode(response.body);
        final signupResponse = await SignupResponse.fromJson(responseData);
        await prefs.setString(
            'fullname', signupResponse.data.fullName.toString());
        await prefs.setString('mobile', signupResponse.data.mobile.toString());
        await prefs.setString('userId', signupResponse.data.id.toString());

        Get.to(otpmobile(), arguments: [
          signupResponse.data.fullName,
          signupResponse.data.mobile
        ]);
      } else if (response.statusCode == 409) {
        Get.snackbar('Message', 'User Already Exist');
        errorMessage.value = 'Failed to fetch user data';
      } else {
        Get.snackbar('Message', 'Invalid Input');
      }
    } catch (error) {
      errorMessage.value = 'Error: $error';
    } finally {
      isLoading.value = false;
    }
  }
}
