// import 'package:dio/dio.dart';
// import 'package:weather/Models/Weather_model.dart';

// class WeatherService{
//   final String baseUrl = 'https://api.weatherapi.com/v1';
//   final String apiKey = 'f0d936b235434eafb72161441231809';

//   final Dio dio;
//   WeatherService({required this.dio});

//   Future<weatherModel> getCurrentWeather({required String CityName}) async {
//     try {
//       Response response = await dio.get('$baseUrl/forecast.json?key=$apiKey&q=$CityName&days=1');
  
//       weatherModel WeatherModel = weatherModel.fromJson(response.data);

// //  print('City: ${WeatherModel.CityName}');
// //     print('Temperature: ${WeatherModel.temp}');


//       return WeatherModel;
//     }on DioException catch (e) {
//       final String errMessage = e.response?.data['error']['message'] ?? 'oops there was error,try later';
//        throw Exception(errMessage);
//     }
//   }
// }

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/Models/Weather_model.dart';

class WeatherService {
  final String baseUrl = 'https://api.weatherapi.com/v1';
  final String apiKey = 'f0d936b235434eafb72161441231809';

  final Dio dio;
  WeatherService({required this.dio});

  // الحصول على الموقع الحالي
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // التحقق من تمكين خدمة الموقع
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    // طلب الإذن للوصول إلى الموقع
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // جلب الموقع الحالي
    return await Geolocator.getCurrentPosition();
  }

  // جلب الطقس بناءً على الموقع الحالي
  Future<weatherModel> getWeatherByLocation() async {
    try {
      // جلب الموقع الحالي
      Position position = await getCurrentLocation();
print('Current location: ${position.latitude}, ${position.longitude}');

      // استدعاء API بناءً على إحداثيات الموقع
      Response response = await dio.get(
        '$baseUrl/forecast.json?key=$apiKey&q=${position.latitude},${position.longitude}&days=1',
      );
   print('API Response: ${response.data}');

      weatherModel WeatherModel = weatherModel.fromJson(response.data);
      return WeatherModel;
    } on DioException catch (e) {
      final String errMessage = e.response?.data['error']['message'] ?? 'oops there was an error, try later';
      print('Error: $errMessage');
      throw Exception(errMessage);
      
    }
  }
}
