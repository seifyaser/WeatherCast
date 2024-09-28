import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/screens/homepage.dart';

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
              //LinearGradient make mix of colors as u like
          gradient: LinearGradient(
            end: Alignment.topCenter,
            colors: [
              
              Colors.black,
              Colors.deepPurple,
             //
            ]
            )
            ),
          child: Column(
            children: [
            
               Lottie.asset('assets/splash.json'),
               Lottie.asset('assets/loading.json')
              
            ],
          ),
        ),
      ),
    );
  }

   Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => homepage()),
);

  }
}