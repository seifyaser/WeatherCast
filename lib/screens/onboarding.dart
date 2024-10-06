import 'package:flutter/material.dart';
import 'package:lottie_screen_onboarding_flutter/introduction.dart';
import 'package:lottie_screen_onboarding_flutter/introscreenonboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/screens/homepage.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  bool isFirstTime = true; // متغير لتخزين حالة أول مرة

  @override
  void initState() {
    super.initState();
    checkFirstTime();
  }

  void checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('isFirstTime') ?? true;

    if (firstTime) {
      // إذا كانت أول مرة، قم بتحديث حالة المتغير
      setState(() {
        isFirstTime = true;
      });
      await prefs.setBool('isFirstTime', false);
    } else {
      // إذا لم تكن أول مرة، قم بتوجيه المستخدم إلى الشاشة الرئيسية
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  Homepage()),
      );
    }
  }

  final List<Introduction> list = [
    Introduction(
      lottieUrl: 'assets/Welcome.json',
      title: 'Welcome to WeatherCast',
      subTitle:
          'Enjoy effortless daily weather updates and stay ahead of the weather.',
    ),
    Introduction(
      lottieUrl: 'assets/location.json',
      title: 'At Your Location',
      subTitle: 'Know the weather anytime with one click at your location.',
    ),
    Introduction(
      lottieUrl: 'assets/Searchcity.json',
      title: 'Explore world’s weather!',
      subTitle:
          'You can search and discover weather forecasts for cities around the globe.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // تحقق مما إذا كان أول مرة، وإذا كانت كذلك اعرض شاشة الـ onboarding
    if (isFirstTime) {
      return Scaffold(
        body: SafeArea(
          child: IntroScreenOnboarding(
            introductionList: list,
            onTapSkipButton: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) =>  Homepage())),
            backgroudColor: const Color.fromARGB(255, 255, 255, 255),
            foregroundColor: const Color.fromARGB(255, 112, 86, 208),
            skipTextStyle: const TextStyle(
              color: Color.fromARGB(255, 112, 86, 208),
              fontSize: 15,
            ),
          ),
        ),
      );
    } else {
      // إذا لم تكن أول مرة، أعد توجيه المستخدم إلى الشاشة الرئيسية مباشرة
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
