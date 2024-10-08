import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/screens/WeatherWeekScreen.dart';

class NextDaysButton extends StatelessWidget {
  final String cityName;

  NextDaysButton({required this.cityName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WeatherWeekScreen(CityName: cityName)),
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
                  textStyle: TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(width: 7),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              width: 28,
              height: 28,
              child: Icon(
                Icons.arrow_forward,
                color: Colors.black,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

