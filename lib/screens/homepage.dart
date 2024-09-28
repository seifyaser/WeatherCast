import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:weather/Models/Weather_model.dart';
import 'package:weather/components/aligns_homepage.dart';
import 'package:weather/components/maxtemp_widget.dart';
import 'package:weather/components/mintemp_widget.dart';
import 'package:weather/components/sunrise_widget.dart';
import 'package:weather/components/sunset_widget.dart';
import 'package:weather/services/weather_service.dart';


class homepage extends StatefulWidget {
   homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  WeatherService weatherService = WeatherService(dio: Dio());
  weatherModel? currentWeather;
  bool isLoading = true;
  String errorMessage = '';
   @override
  void initState() {
    super.initState();
    fetchWeather();
  }

//method for fetch data
 Future<void> fetchWeather() async {
  try {
    print("Starting to fetch weather data...");

    // استدعاء الخدمة لجلب الطقس بناءً على الموقع الحالي
    weatherModel weatherData = await weatherService.getWeatherByLocation();
    
  
    print("Weather data: ${weatherData.toJson()}"); 
    
    if (weatherData != null) {
      print("Weather data fetched successfully!");
      setState(() {
        currentWeather = weatherData;
        isLoading = false;
      });
    } else {
      print("Weather data is null");
      setState(() {
        errorMessage = "No data available.";
        isLoading = false;
      });
    }
  } catch (e) {
    print("Error fetching weather data: $e");
    setState(() {
      errorMessage = e.toString();
      isLoading = false;
    });
  }
}

//method for refresh indicator
Future<void> _refresh() async {
    // تحديث البيانات عند السحب للأسفل
    await fetchWeather();
  }

//method for greetings text
String _getGreeting() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

   String _getWeatherImage(String weatherCondition) {
    //خلي weathercondition 
    //اللي راجع من Api كل حروفه small
    switch (weatherCondition.toLowerCase()) {
      case 'sunny':
        return 'assets/sunny.png';
      case 'rainy':
        return 'assets/rainy.png';
      case 'cloudy':
        return 'assets/cloudy.png';
      case 'thunderstorm':
        return 'assets/thunderstorm.png';
   
      default:
        return 'assets/default.png'; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark
        ),
      ),
      
      body:  RefreshIndicator(
        onRefresh: _refresh,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : errorMessage.isNotEmpty
                ? Center(
                    child: Text(
                      'Error: $errorMessage',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : SingleChildScrollView(
                   child: 
      Padding(padding: EdgeInsets.fromLTRB(25, 50, 30,50),
      child: SizedBox(
        height: MediaQuery.of(context).size.height, // responsive height
        child: Stack(
          children: [
         const align1(),
         const align2(),
         const align3(),

 //blur on background
 BackdropFilter(filter: ImageFilter.blur(sigmaX: 100,sigmaY: 100),
 child: Container(decoration: BoxDecoration(color: Colors.transparent),),
 ),
 SizedBox(
  //responive width and height
  width: MediaQuery.of(context).size.width,
  height: MediaQuery.of(context).size.height,
  child:  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('📍 ${currentWeather?.CityName ?? 'Unknown Location'}',
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 15),
              ),
                IconButton(
          icon: Icon(MdiIcons.mapSearch,size: 30, color: Colors.white),
          onPressed: () {
            // أضف هنا الوظيفة التي تريد تنفيذها عند الضغط على أيقونة البحث
          },)
            ],
          ),
          SizedBox(height: 5,),
            Text(_getGreeting(),
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30)
            ),
             Padding(
               padding: const EdgeInsets.only(left: 25),
               child: Image.asset(
                       _getWeatherImage(currentWeather?.WeatherCondition ?? 'default'),
                         width: 300,
                         height: 300,
                         ),
             ),
        ],
      ),
         Center(
          child: Text( '${currentWeather?.temp.toInt() ?? '--'}°C',
          style: TextStyle(color: Colors.white,
          fontSize: 55,
          fontWeight: FontWeight.w600
          ),
          ),
        ),
         Center(
          child: Text('${currentWeather?.WeatherCondition ?? 'N/A'}',
          style:const TextStyle(color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w300
          ),
          ),
        ),
        const SizedBox(height: 5,),
          Center(
          child: Text(
            //by using intl to format
            currentWeather != null
            ? 'Updated at ${DateFormat('EEE.').format(DateTime.parse(currentWeather!.date))} • ${DateFormat('HH:mm').format(DateTime.parse(currentWeather!.date))}'
            : 'Updated at Unknown',
          style: TextStyle(color: Color.fromARGB(141, 255, 255, 255),
          fontSize: 20,
          fontWeight: FontWeight.w300
          ),
          ),
        ),
        const SizedBox(height: 30,),

        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               sunriseWidget(currentWeather: currentWeather,),
                SunsetWidget(currentWeather: currentWeather,),
              ],
            ),
          ],
        ),

        const Padding(padding: EdgeInsets.symmetric(vertical: 5),
        child: Divider(color: Color.fromARGB(174, 158, 158, 158),
        thickness: 0.4,
        indent: 25,
        endIndent: 20,
        ),
        ),
         
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MaxtempWidget(currentWeather: currentWeather),
            MinTempWidget(currentWeather: currentWeather)
          ],
        ),
      ],
      ),
 )
        ],),
      ),
      ),
    )
     )
     ) ;
  }
}