import 'package:flutter/material.dart';
import 'package:lottie_screen_onboarding_flutter/introduction.dart';
import 'package:lottie_screen_onboarding_flutter/introscreenonboarding.dart';
import 'package:weather/screens/homepage.dart';

class onBoarding extends StatefulWidget {
  const onBoarding({super.key});

  @override
  State<onBoarding> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<onBoarding> {
  final List<Introduction> list = [
    Introduction(
      lottieUrl: 'assets/Welcome.json',
     title: 'Welcome to WeatherCast',
      subTitle: 'Enjoy effortless daily weather updates and stay ahead of the weather.',
      ),
    Introduction(
      lottieUrl: 'assets/location.json',
     title: 'At Your Location',
      subTitle: 'Know the weather anytime with one click at your location.'
      ),
      Introduction(
      lottieUrl: 'assets/Searchcity.json',
     title: 'Explore world’s weather!',
      subTitle: 'You can search and discover weather forecasts for cities around the globe.'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   body: SafeArea(
     child: IntroScreenOnboarding(
      introductionList: list,
      onTapSkipButton: () => Navigator.push(context, MaterialPageRoute(builder: ((context) => homepage()))),
      backgroudColor:Color.fromARGB(255, 213, 213, 213),
      foregroundColor: Color.fromARGB(255, 112, 86, 208),
      skipTextStyle: const TextStyle(
        color: Color.fromARGB(255, 112, 86, 208),
        fontSize: 18,
    
      ),
     )
   ), 
    );
  }
}

