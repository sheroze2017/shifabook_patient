import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifabook/Global.dart';
import 'package:shifabook/views/home.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'bookingLog.dart';

class MyWidget extends StatelessWidget {
  String url;
  String internalTransaction;
  MyWidget({required this.url, required this.internalTransaction});

  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Screen',
            style: TextStyle(color: Colors.black, letterSpacing: 1)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: WebViewWidget(
          controller: WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setBackgroundColor(const Color(0x00000000))
            ..setNavigationDelegate(
              NavigationDelegate(
                onProgress: (int progress) {
                  // Update loading bar.
                },
                onPageStarted: (String url) {},
                onPageFinished: (String url) {},
                onUrlChange: (change) async {
                  if (change.url == '$baseUrl/bookings/post-payment-file') {
                    print('finally found it');

                    bool paymentSuccess =
                        await makepayment(internalTransaction);
                    Future.delayed(Duration(seconds: 5)).then((value) {
                      if (paymentSuccess == true) {
                        Get.back(result: true);

                        // Get.offNamedUntil('/details', (route) => false);
                      }
                      Get.snackbar('Message', 'Payment Successfully Done',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor:
                              const Color.fromARGB(255, 104, 232, 108),
                          colorText: Colors.white);
                    });
                  }

                  // if (change ==
                  //     Uri.parse(
                  //         '$baseUrlbookings/post-payment-file')) {
                  //   print('finally found url');
                  // }
                },
                onWebResourceError: (WebResourceError error) {},
                onNavigationRequest: (NavigationRequest request) {
                  if (request.url.startsWith('https://www.youtube.com/')) {
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              ),
            )
            ..loadRequest(Uri.parse(url))),
    );
  }
}

Future<bool> makepayment(String internal) async {
  try {
    bool val = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accesstoken = await prefs.getString('access_Token');
    String url = '$baseUrl/bookings/get-payment/$internal';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $accesstoken",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final res = data['message'];
      if (res == "Your Payment hasn't been processed yet. Please try again") {
        print('not found');
        return false;
      } else if (res ==
          "Your Payment is processed. Awating for doctor approval. Thank you") {
        print('success found');
        return true;
      }
    } else {
      print('Error: ${response.statusCode}');
    }

    return false; // Default to false if no valid response is received
  } catch (e) {
    print('Error: $e');
    return false; // Return false on any error
  }
}
