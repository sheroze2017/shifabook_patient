import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectivityController extends GetxController {
  final snackbar = Get.snackbar;
  var internetStatus = true.obs;
  var previousStatus = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initiateInternetConnectionStream();
  }

  void _initiateInternetConnectionStream() async {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        internetStatus.value = true;
        previousStatus.value
            ? null
            : showToastMessage("Internet Connected", Colors.green, false);
        previousStatus.value = true;
      } else {
        internetStatus.value = false;
        previousStatus.value = false;

        showToastMessage("No Internet Access", Colors.red, true);
      }
    });
  }
}

void showToastMessage(String message, Color color, bool connect) =>
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: color,
        timeInSecForIosWeb: connect ? 365 * 24 * 60 * 60 : 2);
