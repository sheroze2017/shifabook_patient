import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shifabook/views/ProfileScreen.dart';
import '../userData/userInfo.dart';

class UpdatePofile extends GetxController {
  var isloading = false.obs;
  updatePatientProfile(
    String fullname,
    String age,
    List<dynamic> allergies,
    List<dynamic> disease,
    String cityid,
    String weight,
    String height,
  ) async {
    try {
      isloading.value = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? access_token = await prefs.getString('access_Token');
      final body = {
        "full_name": fullname,
        "age": int.parse(age),
        "allergies": allergies,
        "disease": disease,
        "city_id": int.parse(cityid),
        "weight": weight,
        "height": height
      };
      print(access_token);
      String url =
          'http://3.80.54.173:4005/api/v1/patients/update-patient-profile';
      final response = await http.put(Uri.parse(url),
          headers: {
            "Authorization": "Bearer $access_token",
            "Content-Type": "application/json",
          },
          body: jsonEncode(body));

      if (response.statusCode == 200) {
        Get.snackbar('Message', 'Profile Updated');
        await UserProfileService().fetchAndStoreProfile();

        // Successful response
      } else {
        Get.snackbar('Error', 'Invalid Data');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error creating doctor: $error');
      Get.snackbar('Error', 'Invalid Credentials');

      // Handle any error messages or UI updates here
    } finally {
      isloading.value = false;
    }
  }
}
