import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:weather/components/aligns_homepage.dart';

class WeatherWeekScreen extends StatelessWidget {
  final List<Map<String, dynamic>> weatherData = [
    {"day": "Sun", "icon": Icons.wb_sunny, "description": "Sunny", "temp": 17},
    {"day": "Mon", "icon": Icons.grain, "description": "Rainy", "temp": 16},
    {"day": "Tue", "icon": Icons.flash_on, "description": "Storm", "temp": 14},
    {"day": "Wed", "icon": Icons.ac_unit, "description": "Snow", "temp": 21},
    {"day": "Thu", "icon": Icons.bolt, "description": "Thunder", "temp": 15},
    {"day": "Fri", "icon": Icons.grain, "description": "Rainy", "temp": 18},
    {"day": "Sat", "icon": Icons.ac_unit, "description": "Slow", "temp": 14},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Container(
        child: Stack(
          children: [
            const align4(),
            const align2(),
            const align1(),
            //  blur on background
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(decoration: BoxDecoration(color: Colors.transparent)),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // ضبط المسافات بين العناصر
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom:85),
                          child: Row(
                            children: [
                              Container(
                                width: 29,
                                height: 35,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white, // لون الدائرة
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20), // لون الأيقونة
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Back',
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(color: Colors.white, fontSize: 25),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/4.png',
                          width: 200, // ضبط عرض الصورة
                          height:150, // ضبط ارتفاع الصورة
                          fit: BoxFit.cover, // ضبط تناسق الصورة
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Icon(MdiIcons.calendarMonthOutline, size: 40, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        "This Week",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(color: Colors.white, fontSize: 35),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: weatherData.length,
                    itemBuilder: (context, index) {
                      var dayWeather = weatherData[index];
                      return Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20), // ضبط الحشوات
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    dayWeather['day'],
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(color: Colors.white, fontSize: 30),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center, // لتوسيع النص إلى المركز
                                    children: [
                                      Icon(dayWeather['icon'], color: Colors.white),
                                      SizedBox(width: 10), // المسافة بين الرمز والوصف
                                      Text(
                                        dayWeather['description'],
                                        style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(color: Colors.white, fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "${dayWeather['temp']}°",
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(color: Colors.white, fontSize: 50),
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(color: const Color.fromARGB(165, 255, 255, 255).withOpacity(0.2), endIndent: 30, indent: 30,), // Divider بين كل صف
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
