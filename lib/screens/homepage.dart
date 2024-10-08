import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather/Models/Weather_model.dart';
import 'package:weather/components/SearchFloatingActionButton.dart';
import 'package:weather/components/aligns_homepage.dart';
import 'package:weather/components/maxtemp_widget.dart';
import 'package:weather/components/mintemp_widget.dart';
import 'package:weather/components/next_days_buttons.dart';
import 'package:weather/components/sunrise_widget.dart';
import 'package:weather/components/sunset_widget.dart';
import 'package:weather/services/weather_service.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  WeatherService weatherService = WeatherService(dio: Dio());
  weatherModel? currentWeather;
  bool isLoading = true;
  String errorMessage = '';
  String searchCity = '';

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  //method for fetch data
  Future<void> fetchWeather() async {
    try {
      print("Starting to fetch weather data...");

      // إذا كان هناك مدينة بحث محددة، استخدمها، خلاف ذلك استخدم الموقع الحالي
      weatherModel weatherData;
      if (searchCity.isNotEmpty) {
        weatherData = await weatherService.getCurrentWeather(CityName: searchCity);
      } else {
        weatherData = await weatherService.getWeatherByLocation(context);
      }

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

  void _onSearch(String cityName) {
    if (cityName.isNotEmpty) {
      setState(() {
        searchCity = cityName;
        isLoading = true;
        fetchWeather(); // استدعاء جلب الطقس عند تغيير المدينة
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
    // خلي weathercondition 
    // اللي راجع من Api كل حروفه small
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
      
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: isLoading
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
                    Text('Starting to fetch weather data...', style: TextStyle(color: Colors.white)),
                    SizedBox(height: 20),
                    CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                  ],
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
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(25, 50, 30, 50),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height, // responsive height
                        child: Stack(
                          children: [
                            const align1(),
                            const align2(),
                            const align3(),

                            //blur on background
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                              child: Container(decoration: BoxDecoration(color: Colors.transparent)),
                            ),
                            SizedBox(
                              //responive width and height
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('📍 ${currentWeather?.CityName ?? 'Unknown Location'}',
                                        // style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20),
                                        style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(_getGreeting(),
                                        // style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30)
                                         style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                                  ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 25),
                                        child: Image.asset(
                                          _getWeatherImage(currentWeather?.WeatherCondition ?? 'default'),
                                          width: 300,
                                          height: 300,
                                        ),
                                      ),
                                    ]),
                                  Center(
                                    child: Text('${currentWeather?.temp.toInt() ?? '--'}°C',
                                      // style: TextStyle(color: Colors.white, fontSize: 55, fontWeight: FontWeight.w600),
                                      style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(color: Colors.white, fontSize: 55, fontWeight: FontWeight.bold),
                                  ),
                                    ),
                                  ),
                                  Center(
                                    child: Text('${currentWeather?.WeatherCondition ?? 'N/A'}',
                                      style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w300),
                                  ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Center(
                                  child: Text(
                                  currentWeather != null
                                  ? ' ${DateFormat('EEEE d ').format(DateTime.parse(currentWeather!.date))}• ${DateFormat('hh:mm a').format(DateTime.parse(currentWeather!.date))}' 
                                  : 'Updated at Unknown',
                                  // style: TextStyle(color: Color.fromARGB(141, 255, 255, 255), fontSize: 20, fontWeight: FontWeight.w300),
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(color: Color.fromARGB(141, 255, 255, 255), fontSize: 20, fontWeight: FontWeight.w300),
                                  ),
                                 ),
                                 ),
                                  const SizedBox(height: 20),
                                   NextDaysButton(cityName: currentWeather?.CityName ?? 'Unknown Location'),

                                  const SizedBox(height: 20),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          sunriseWidget(currentWeather: currentWeather),
                                          SunsetWidget(currentWeather: currentWeather),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Divider(color: Color.fromARGB(174, 158, 158, 158), thickness: 0.6, indent: 25, endIndent: 20),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      MaxtempWidget(currentWeather: currentWeather),
                                      MinTempWidget(currentWeather: currentWeather)
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                 
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
      ),

      floatingActionButton: SearchFloatingActionButton(
        isLoading: isLoading,
        onSearch: _onSearch,
      ),
    ); 
   
    
    
  }
}
