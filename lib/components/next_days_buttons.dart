import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/screens/next_days_weather.dart';

class NextDaysButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => WeatherWeekScreen()),
);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: <Color>[
                    
                    Color(0xFFDA70D6), 
                    Color.fromARGB(255, 44, 140, 147)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: Text(
                'Next days',
                style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.w500,),
                                  ),
                ),
              ),
            
            SizedBox(width: 7),
            Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white, // لون الدائرة
                  ),
                  width: 28, // عرض الدائرة
                  height: 28, // ارتفاع الدائرة
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.black, // لون السهم
                    size: 24, // حجم السهم
                  ),
                ),
          ],
        ),
      ),
    );
  }
}