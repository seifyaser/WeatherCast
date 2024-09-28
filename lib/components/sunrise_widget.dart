import 'package:flutter/material.dart';
import 'package:weather/Models/Weather_model.dart';

class sunriseWidget extends StatelessWidget {
 
  final weatherModel? currentWeather;

  const sunriseWidget({super.key,required this.currentWeather});

  @override
  Widget build(BuildContext context) {
    
    return  Row(
                  children: [ 
                  Image.asset('assets/10.png',
                  scale: 8,
                ),
                const SizedBox(width: 5,),
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sunrise',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300
                    ),
                    ),
                    SizedBox(height: 3,),
                      Text('${currentWeather?.Sunrise ?? '--'}',
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