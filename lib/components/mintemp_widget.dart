import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/Models/Weather_model.dart';

class MinTempWidget extends StatelessWidget {
  const MinTempWidget({super.key,required this.currentWeather});
 final weatherModel? currentWeather;
  @override
  Widget build(BuildContext context) {
    return  Row(
              children: [ 
              Image.asset('assets/14.png',
              scale: 8,
            ),
            const SizedBox(width: 5,),
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Temp. Min',
                 style: GoogleFonts.montserrat(
                   textStyle:const TextStyle(color: Color.fromARGB(141, 255, 255, 255), fontWeight: FontWeight.w600,fontSize: 12),)
                ),
                SizedBox(height: 3,),
                  Text('${currentWeather?.MinTemp.toInt() ?? '--'}°C',
                 style: GoogleFonts.montserrat(
                   textStyle:const TextStyle(color: Colors.white, fontWeight: FontWeight.w700,fontSize: 15),)
                ),
              ],
            )
            ]
            );
  }
}