import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifabook/Global.dart';

import 'package:shifabook/views/form_screen.dart';
import 'dart:convert';

import 'package:shifabook/views/home.dart';

import '../../model/login_controller_model.dart';
import '../userData/userInfo.dart';

class LoginController extends GetxController {
  var status = false.obs;
  var message = ''.obs;
  var error = ''.obs;
  var userId = 0.obs;
  var fullName = ''.obs;
  var email = ''.obs;
  var mobile = ''.obs;
  var isActive = false.obs;
  var isVerify = false.obs;
  var createdAt = ''.obs;
  var updatedAt = ''.obs;
  var roleId = 0.obs;
  var roleName = ''.obs;
  var accessToken = ''.obs;
  var refreshToken = ''.obs;
  var expiresIn = ''.obs;
  var refreshExpiresIn = ''.obs;
  var isloading = false.obs;
  var logoutLoader = false.obs;
  Future<void> login(String mobileno, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    isloading.value = true;
    String apiUrl = '$baseUrl/users/login';

    try {
      Map<String, String> data = {
        'mobile': mobileno,
        'password': password,
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print(response.body);
        var responseData = await response.body;
        var loginResponse = await UserModel.fromJson(jsonDecode(responseData));
        //  print(loginResponse);
        print(loginResponse.data.user.fullName);
        // Access the data from the loginResponse object
        await prefs.setString(
            'fullname', loginResponse.data.user.fullName.toString());
        await prefs.setString('userId', loginResponse.data.user.id.toString());
        await prefs.setString(
            'email', loginResponse.data.user.email.toString());
        await prefs.setString(
            'mobile', loginResponse.data.user.mobile.toString());
        await prefs.setString(
            'isActive', loginResponse.data.user.isActive.toString());
        await prefs.setString(
            'isVerify', loginResponse.data.user.isVerify.toString());
        await prefs.setString(
            'createdAt', loginResponse.data.user.createdAt.toString());
        await prefs.setString(
            'updatedAt', loginResponse.data.user.updatedAt.toString());
        await prefs.setString(
            'roleName', loginResponse.data.user.role.name.toString());
        await prefs.setString(
            'roleId', loginResponse.data.user.role.id.toString());
        await prefs.setString(
            'access_Token', loginResponse.data.accessToken.toString());
        await prefs.setString(
            'refresh_Token', loginResponse.data.refreshToken.toString());

        print('Access Token: ${loginResponse.data.accessToken}');
        print('User Full Name: ${loginResponse.data.user.fullName}');
        // Get.to(() => formScreen());

        // ... Access other properties as needed
        if (loginResponse.data.user.isProfileCreated == false) {
          Get.to(() => formScreen());
        } else {
          await UserProfileService().fetchAndStoreProfile();
          Get.offAll(() => HomePage());
        }
      } else if (response.statusCode == 404) {
        // Invalid credentials
        Get.snackbar('Error', 'Invaild Credentials');
        //print('Invalid credentials');
      } else {
        // Error occurred during login
        print('Login failed');
      }
    } catch (error) {
      print('An error occurred: $error');
      // Handle connection errors or other exceptions
    } finally {
      isloading.value = false;
    }
  }
}
