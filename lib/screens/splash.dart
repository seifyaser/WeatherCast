import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/screens/onboarding.dart';

class spalsh extends StatefulWidget {
  const spalsh({super.key});

  @override
  State<spalsh> createState() => _spalshState();
}

class _spalshState extends State<spalsh> 
with SingleTickerProviderStateMixin
{

  @override
void initState(){
  super.initState();
redirect();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration:const BoxDecoration( 
         color: Colors.black
            ),
          child: Column(
            children: [
            
               Padding(
                 padding: const EdgeInsets.only(top: 150),
                 child: Lottie.asset('assets/splash.json'),
               ),

            Padding(
              padding: const EdgeInsets.only(top: 220),
              child: Center(
                child: Column(
                  children: [Text('WeatherCast',style: TextStyle(color: Colors.white),),
                  Text('V 1.0',style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            )
            ],
          ),
        ),
      ),
    );
  }

   Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => OnBoarding()),
);

  }
}