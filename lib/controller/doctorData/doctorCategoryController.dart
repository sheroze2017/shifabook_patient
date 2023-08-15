import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/doctorCategory.dart';

class DoctorData extends GetxController {
  var fullName = [].obs;
  var img = [].obs;
  // var doctorUser = [].obs;
  var doctors = <DoctorUser>[].obs;

  addDoctor(DoctorUser doctor) {
    doctors.add(doctor);
  }

  DoctorCategory? accountData;

  fetchDoctors(int id) async {
    fullName.clear();
    img.clear();
    doctors.clear();
    // doctorUser.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? access_token = await prefs.getString('access_Token');

    final url = Uri.parse('http://3.80.54.173:4005/api/v1/home/category/$id');

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $access_token",
        },
      );
      if (response.statusCode == 200) {
        accountData = await DoctorCategory.fromJson(jsonDecode(response.body));
        for (int i = 0; i < accountData!.data!.length; i++) {
          fullName.add(accountData!.data![i].fullName);
          img.add(accountData!.data![i].image);
          var doctorData = accountData!.data![i];
          var doctor = await DoctorUser(
            affilation: List<String>.from(
                doctorData.doctorUser!.affilation as Iterable),
            qualification: List<String>.from(
                doctorData.doctorUser!.qualification as Iterable),
            yearsOfExperience: doctorData.doctorUser!.yearsOfExperience,
            onsiteConsultationFee: doctorData.doctorUser!.onsiteConsultationFee,
            onlineConsultationFee: doctorData.doctorUser!.onlineConsultationFee,
          );

          await addDoctor(doctor);
        }
        // print(doctorUser);
        print('User profile data saved to local storage');
      } else {
        print(response.body);
        print('API call failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching and storing API data: $error');
    }
  }

  // doctors.assignAll([
  //   Doctor(
  //     fullName: "Dr. Taha Shahid",
  //     doctorUser: DoctorUser(
  //       affilation: ["Aga Khan Hospital", "EXY Clinic"],
  //       qualification: ["MBBS", "MD"],
  //       yearsOfExperience: 4,
  //       onsiteConsultationFee: 1000,
  //       onlineConsultationFee: 500,
  //     ),
  //   ),
  //   // Add more doctors here
  // ]);
}
