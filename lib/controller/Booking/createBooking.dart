import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifabook/views/Booking/paymentGateway.dart';

class Createbooking extends GetxController {
  var isloading = false.obs;
  var bookings = <Booking>[].obs;
  var isLoading2 = false.obs;
  Map<String, dynamic> bookingData = {};
  var isLoading3 = false.obs;
  RxString paymentHref = ''.obs;

  createBook(String time, int doctorid, int landmarkid, int onsitefees) async {
    isloading.value = true;
    try {
      paymentHref.value = '';

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accesstoken = await prefs.getString('access_Token');
      final body = {
        "scheduled_at": time,
        "doctor_id": doctorid,
        "landmark_id": landmarkid
      };
      String url = 'http://3.80.54.173:4005/api/v1/bookings/create-booking';
      final response = await http.post(Uri.parse(url),
          headers: {
            "Authorization": "Bearer $accesstoken",
            "Content-Type": "application/json",
          },
          body: jsonEncode(body));

      if (response.statusCode == 200) {
        Get.snackbar('Statue', 'Booking done waiting for Payment');
        final data = await json.decode(response.body);
        int payid = await data['data']['id'];
        print('fins');
        print(payid);
        print('fins');
        final body2 = {
          "doctor_id": doctorid,
          "booking_id": payid,
          "amount": onsitefees
        };
        String url = 'http://3.80.54.173:4005/api/v1/bookings/make-payment';
        final response2 = await http.post(Uri.parse(url),
            headers: {
              "Authorization": "Bearer $accesstoken",
              "Content-Type": "application/json",
            },
            body: jsonEncode(body2));
        if (response2.statusCode == 200) {
          //  Get.snackbar('Status', 'Directing Url');
          final dat = await json.decode((response2.body));
          print(dat);
          print(dat['data']);
          String internalTransaction =
              await dat['data']['internal_transaction_id'];
          print(dat['data']['payment_link']['href']);
          String paylink = await dat['data']['payment_link']['href'];

          bool result = await Get.to(MyWidget(
            url: paylink,
            internalTransaction: internalTransaction,
          ));
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  color: result ? Colors.green : Colors.red,
                  size: 60,
                ),
                SizedBox(height: 16),
                Text(
                    result ? 'Payment Successfully Done' : 'Transaction Error'),
              ],
            ),
          );
        }

        // isloading.value = false;
      } else {
        Get.snackbar('Error', 'Invalid Data');
      }
    } catch (e) {
      print(e);
    } finally {
      isloading.value = false;
    }
  }

  getBooking() async {
    bookings.clear();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accesstoken = await prefs.getString('access_Token');

      String url = 'http://3.80.54.173:4005/api/v1/bookings/patient-bookings';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $accesstoken",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        final data = json.decode(response.body);
        final List<dynamic> statusData = data['data'];

        bookings.value = statusData
            .map((bookingData) => Booking(
                  id: bookingData['id'],
                  scheduledAt: bookingData['scheduled_at'],
                  isCompleted: bookingData['is_completed'],
                  isActive: bookingData['is_active'],
                  doctorFullName: bookingData['booking_log_doctor']
                      ['full_name'],
                  landmarkName: bookingData['landmark']['name'],
                  bookingStatus: bookingData['booking_status'],
                ))
            .toList();
      } else {
        // Handle error
      }
    } catch (error) {
      // Handle error
    } finally {
      isLoading2.value = false;
    }
  }

  getbookingdetails(int id) async {
    bookingData.clear();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accesstoken = await prefs.getString('access_Token');

      String url = 'http://3.80.54.173:4005/api/v1/bookings/$id';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $accesstoken",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        bookingData = data;
        print(bookingData);
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle error
      print('Error: $error');
    } finally {
      isLoading3.value = false;
    }
  }

  delayedPayment(int doctorid, int payid, int onsitefees) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accesstoken = await prefs.getString('access_Token');
      final body2 = {
        "doctor_id": doctorid,
        "booking_id": payid,
        "amount": onsitefees
      };
      String url = 'http://3.80.54.173:4005/api/v1/bookings/make-payment';
      final response = await http.post(Uri.parse(url),
          headers: {
            "Authorization": "Bearer $accesstoken",
            "Content-Type": "application/json",
          },
          body: jsonEncode(body2));
      if (response.statusCode == 200) {
        //  Get.snackbar('Status', 'Directing Url');
        final dat = await json.decode((response.body));
        print(dat);
        print(dat['data']);
        String internalTransaction =
            await dat['data']['internal_transaction_id'];
        print(dat['data']['payment_link']['href']);
        String paylink = await dat['data']['payment_link']['href'];

        bool result = await Get.to(MyWidget(
          url: paylink,
          internalTransaction: internalTransaction,
        ));
      } else {
        Get.snackbar('Error', 'Invalid Data');
      }
    } catch (e) {
    } finally {}
  }
}

class Booking {
  final int id;
  final String scheduledAt;
  final bool isCompleted;
  final bool isActive;
  final String doctorFullName;
  final String landmarkName;
  final String bookingStatus;

  Booking({
    required this.id,
    required this.scheduledAt,
    required this.isCompleted,
    required this.isActive,
    required this.doctorFullName,
    required this.landmarkName,
    required this.bookingStatus,
  });
}
