import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:weather/components/aligns_homepage.dart';
import 'package:weather/services/weather_service.dart';

class WeatherWeekScreen extends StatefulWidget {
  final String CityName;

  const WeatherWeekScreen({super.key, required this.CityName});
  
  @override
  State<WeatherWeekScreen> createState() => _WeatherWeekScreenState();
}

class _WeatherWeekScreenState extends State<WeatherWeekScreen> {
  final WeatherService weatherService = WeatherService(dio: Dio());
  
  List<dynamic>? forecast;
  bool isLoading = true; // متغير للتحكم في حالة التحميل
String weatherImage = '';
  @override
  void initState() {
    super.initState();
    fetchForecast();
  }

  Future<void> fetchForecast() async {
    try {
      final forecastData = await weatherService.fetch7dayForecast(widget.CityName);
      
      if (forecastData != null && forecastData.isNotEmpty) {
        print('Forecast Data: $forecastData');

        setState(() {
          forecast = forecastData;
          isLoading = false; // تغيير حالة التحميل
          weatherImage = getWeatherImage(forecastData[0]['day']['condition']['text']);
        });

        ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Weather Week fetched'))
        );
      } else {
        print('No forecast data available.');
        setState(() {
          isLoading = false; // تغيير حالة التحميل
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No forecast Week available'))
        );
      }
    } catch (e) {
      print('Error fetching forecast: $e');
      setState(() {
        isLoading = false; // تغيير حالة التحميل
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching weather data'))
      );
    }
  }

 String getWeatherImage(String condition) {
    if (condition.toLowerCase().contains('sunny')) {
      return 'assets/sunny.png';
    } else if (condition.toLowerCase().contains('rain')) {
      return 'assets/rainy.png';
    } else if (condition.toLowerCase().contains('cloud')) {
      return 'assets/cloudy.png';
    } else if (condition.toLowerCase().contains('thunderstorm')) {
      return 'assets/thunderstorm.png';
    }
    return 'assets/default.png'; // صورة افتراضية إذا لم توجد حالة
  }

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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom:85),
                          child: Row(
                            children: [
                              Container(
                                width: 29,
                                height: 35,
                                decoration:const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
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
                          weatherImage.isNotEmpty
                          ? Image.asset(
                              weatherImage,
                              width: 155, // ضبط عرض الصورة
                              height: 120, // ضبط ارتفاع الصورة
                              fit: BoxFit.cover, // ضبط تناسق الصورة
                            )
                          : SizedBox.shrink(), // في حالة عدم وجود صورة
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
                  child: isLoading 
                      ? const Center(
                          child: CircularProgressIndicator(color: const Color.fromARGB(255, 18, 79, 183)),
                        )
                      : ListView.builder(
                          itemCount: forecast?.length ?? 0,
                          itemBuilder: (context, index) {
                            final day = forecast![index];
                            final iconUrl = 'http:${day['day']['condition']['icon']}';
                            return Column(
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                                  title: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          DateFormat('EEE').format(DateTime.parse(day['date'])),
                                          style: GoogleFonts.montserrat(
                                            textStyle:const TextStyle(color: Colors.white, fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.network(iconUrl,width: 35,height: 30,),
                                          
                                          Text(
                                            day['day']['condition']['text'],
                                            style: GoogleFonts.montserrat(
                                              textStyle: const TextStyle(color: Colors.white, fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 30),
                                      Expanded(
                                        child: Text(
                                          '${day['day']['avgtemp_c'].round()}°',
                                          style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(color: Colors.white, fontSize: 45),
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(color: const Color.fromARGB(165, 255, 255, 255).withOpacity(0.2), endIndent: 30, indent: 30,),
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
