import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/Models/Weather_model.dart';

class SunsetWidget extends StatelessWidget {

  final weatherModel? currentWeather;

  const SunsetWidget({super.key,required this.currentWeather});


  @override
  Widget build(BuildContext context) {
    return  Row(
                  children: [ 
                  Image.asset('assets/12.png',
                  scale: 8,
                ),
                const SizedBox(width: 5,),
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sunset',
                   style: GoogleFonts.montserrat(
                   textStyle:const TextStyle(color: Color.fromARGB(141, 255, 255, 255), fontWeight: FontWeight.w600,fontSize: 12),)
                    ),
                    SizedBox(height: 3,),
                      Text('${currentWeather?.Sunset ?? '--'}',
                    style: TextStyle(
                      color: Colors.white,
                     fontWeight: FontWeight.w700,fontSize: 15
                    ),
                    ),
                  ],
                )
                ]
                );
  }
}