import 'package:flutter/material.dart';
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
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300
                ),
                ),
                SizedBox(height: 3,),
                  Text('${currentWeather?.MinTemp.toInt() ?? '--'}°C',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700
                ),
                ),
              ],
            )
            ]
            );
  }
}