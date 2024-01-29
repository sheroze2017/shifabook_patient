import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifabook/Global.dart';

import '../../model/doctorCategory.dart';

class DoctorData extends GetxController {
  var fullName = [].obs;
  var img = [].obs;
  var avail = [].obs;
  var doctors = <DoctorUser>[].obs;
  var doctorFetchLoader = false.obs;
  List<DateTime> inactive = [];

  List<dynamic> availability = [];

  addavail(String avail2) async {
    inactive.clear();
    availability.clear();
    availability = jsonDecode(avail2);

    print(availability);
  }

  addDoctor(DoctorUser doctor) {
    doctors.add(doctor);
  }

  DoctorCategory? accountData;
  void sortDoctorsByExperience() {
    doctors
        .sort((a, b) => b.yearsOfExperience!.compareTo(a.yearsOfExperience!));
    print(doctors[0].yearsOfExperience);
  }

  fetchDoctors(int id) async {
    doctorFetchLoader.value = false;
    fullName.clear();
    img.clear();
    doctors.clear();
    avail.clear();
    // doctorUser.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? access_token = await prefs.getString('access_Token');

    final url = Uri.parse('$baseUrl//home/category/$id?limit=10&offset=0');

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $access_token",
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> parsedData = json.decode(response.body);
        //  print(parsedData['data'][0]['doctor_availability']['availability']);
        accountData = await DoctorCategory.fromJson(jsonDecode(response.body));

        for (int i = 0; i < accountData!.data!.length; i++) {
          fullName.add(accountData!.data![i].fullName);
          img.add(accountData!.data![i].image);
          avail.add(jsonEncode(
                  parsedData['data'][i]['doctor_availability']['availability'])
              .toString());
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
    } finally {
      doctorFetchLoader.value = true;
    }
  }
}
