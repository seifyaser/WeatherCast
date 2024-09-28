import 'package:flutter/material.dart';
import 'package:weather/Models/Weather_model.dart';

class MaxtempWidget extends StatelessWidget {
  const MaxtempWidget({super.key,required this.currentWeather});
 final weatherModel? currentWeather;
  @override
  Widget build(BuildContext context) {
    return Row(
              children: [ 
              Image.asset('assets/13.png',
              scale: 8,
            ),
            const SizedBox(width: 5,),
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Temp. MAX',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300
                ),
                ),
                SizedBox(height: 3,),
                  Text('${currentWeather?.MaxTemp.toInt() ?? '--'}°C',
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