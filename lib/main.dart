import 'package:flutter/material.dart';
import 'package:weather/screens/onboarding.dart';
import 'package:weather/screens/homepage.dart';
import 'package:weather/screens/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
 debugShowCheckedModeBanner: false,

 routes: {
 'HomePage' : (context) => homepage(),
 'splash' : (context) => spalsh(),
 'firstpage' : (context) => OnBoarding(),
 //  'Searchview' : (context) => searchview(),
 },
 initialRoute: 'splash',
    );
  }
}
