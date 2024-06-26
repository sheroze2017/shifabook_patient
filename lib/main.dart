import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shifabook/Global.dart';
import 'package:shifabook/views/Booking/bookingLog.dart';
import 'package:shifabook/views/Health/step_screen.dart';
import 'package:shifabook/views/form_screen.dart';
import 'package:shifabook/views/home.dart';
import 'package:shifabook/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifabook/views/news_Screen.dart';
import 'package:shifabook/views/splash_screen.dart';
import 'package:shifabook/views/widgets/connectivity_internet.dart';

import 'controller/userData/userInfo.dart';
import 'views/DoctorInfo/Availability.dart';
import 'views/otp_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'views/Booking/payment_Screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? refresh_token = prefs.getString('refresh_Token');
  String? mobile = prefs.getString('mobile');
  if (refresh_token != null && mobile != null) {
    final url = Uri.parse('${baseUrl}/users/token');
    final body = jsonEncode({
      "email": "{{email}}",
      "mobile": mobile,
      "refresh_token": refresh_token
    });

    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        //print(jsonDecode(response.body)['data']['access_token']);
        // Success
        print('API hit successful');
        String accessToken =
            await jsonDecode(response.body)['data']['access_token'];
        await prefs.setString('access_Token', accessToken.toString());
        print(prefs.getString('access_Token'));
        // await UserProfileService().fetchAndStoreProfile();
      } else {
        // Handle error
        print('Failed to hit the API. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      print('Error hitting the API: $e');
    }
  } else {
    print('print no data yet');
  }
  Timer.periodic(Duration(seconds: 10), (timer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? refresh_token = prefs.getString('refresh_Token');
    String? mobile = prefs.getString('mobile');
    if (refresh_token != null && mobile != null) {
      final url = Uri.parse('$baseUrl/users/token');
      final body = jsonEncode({
        "email": "{{email}}",
        "mobile": mobile,
        "refresh_token": refresh_token
      });
      final headers = {'Content-Type': 'application/json'};
      try {
        final response = await http.post(url, headers: headers, body: body);
        if (response.statusCode == 200) {
          //print(jsonDecode(response.body)['data']['access_token']);
          // Success
          print('API hit successful');
          String accessToken =
              await jsonDecode(response.body)['data']['access_token'];
          await prefs.setString('access_Token', accessToken.toString());
          print(prefs.getString('access_Token'));
          // await UserProfileService().fetchAndStoreProfile();
        } else {
          // Handle error
          print('Failed to hit the API. Status code: ${response.statusCode}');
        }
      } catch (e) {
        // Handle error
        print('Error hitting the API: $e');
      }
    } else {
      print('print no data yet');
    }
  });

  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  // dotenv.load();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      accessFunc();
    } else if (state == AppLifecycleState.inactive) {
      accessFunc();
    } else if (state == AppLifecycleState.paused) {
      accessFunc();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        title: 'ShifaBook',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        getPages: [
          GetPage(name: '/find', page: () => HomePage()),
          GetPage(name: '/f', page: () => formScreen()),
          GetPage(name: '/', page: () => SplashScreen()),
          GetPage(name: '/details', page: () => BookingLogs()),
          GetPage(name: '/fi', page: () => PaymentScreen()),
          GetPage(name: '/stepper', page: () => stepper())
          //  GetPage(
          // name: '/details',
          // page: () => DetailsScreen()),
          //  GetPage(
          // name: '/details',
          // page: () => DetailsScreen()),
          //  GetPage(
          // name: '/details',
          // page: () => DetailsScreen()),
          //  GetPage(
          // name: '/details',
          // page: () => DetailsScreen()),
        ],
        // home: HomePage()
      );
    });
  }
}

accessFunc() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? refreshToken = prefs.getString('refresh_Token');
  String? mobile = prefs.getString('mobile');
  if (refreshToken != null && mobile != null) {
    final url = Uri.parse('$baseUrl/users/token');

    final body = jsonEncode({
      "email": "{{email}}",
      "mobile": mobile,
      "refresh_token": refreshToken
    });

    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        //print(jsonDecode(response.body)['data']['access_token']);
        // Success
        print('API hit successful');
        String accessToken =
            await jsonDecode(response.body)['data']['access_token'];
        await prefs.setString('access_Token', accessToken.toString());
        print(prefs.getString('access_Token'));
        // await UserProfileService().fetchAndStoreProfile();
      } else {
        // Handle error
        print('Failed to hit the API. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      print('Error hitting the API: $e');
    }
  } else {
    print('print no data yet');
  }
}
