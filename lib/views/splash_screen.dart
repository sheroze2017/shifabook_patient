import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifabook/views/home.dart';
import 'package:shifabook/views/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  func() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('refresh_Token');
    if (token != null) {
      Get.offAll(HomePage(), transition: Transition.fade);
    } else {
      Get.offAll(SignIn(), transition: Transition.fade);
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _animationController.forward();

    // Delay navigation to a new screen after 2 seconds
    Future.delayed(Duration(seconds: 5), () {
      func();
      // Get.to(SignIn(), transition: Transition.circularReveal);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradientAnimation = TweenSequence<Color?>(
      [
        TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(
            begin: Colors.grey,
            end: Colors.grey.withOpacity(0.5),
          ),
        ),
        TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(
            begin: Colors.grey.withOpacity(0.5),
            end: Colors.grey,
          ),
        ),
      ],
    ).animate(_animationController);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [
                          gradientAnimation.value!,
                          gradientAnimation.value!,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(bounds);
                    },
                    child: Text(
                      'SHIFABOOK',
                      style: TextStyle(
                        fontSize: 24.sp,
                        wordSpacing: 4,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        color: Color.fromRGBO(82, 172, 245, 1),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 5.h),
              Lottie.asset(
                'assets/animation_llamyje9.json',
                width: 30.h,
                height: 30.h,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
