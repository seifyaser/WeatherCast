class weatherModel{

 final String CityName;
 //datatime is a class return time now
 final String date;
 final double temp;
 final double MaxTemp;
 final double MinTemp;
 final String WeatherCondition;
 final String Sunrise;
 final String Sunset;
 final List<double> dailyTemps;

  weatherModel( {
     required this.dailyTemps,
    required this.CityName,
     required this.date,
      required this.temp,
       required this.MaxTemp,
        required this.MinTemp,
         required this.WeatherCondition,
          required this.Sunrise,
           required this.Sunset});

  factory weatherModel.fromJson(json) {
      List<double> dailyTemperatures = (json['forecast']['forecastday'] as List)
        .map((day) => double.tryParse(day['day']['avgtemp_c'].toString()) ?? 0.0)
        .toList();
  return weatherModel(
    CityName: json['location']['name'],
    // date: DateTime.parse(json['location']['localtime']),
    date: json['location']['localtime'],
    temp: double.tryParse(json['forecast']['forecastday'][0]['day']['avgtemp_c'].toString()) ?? 0.0,
    MaxTemp: double.tryParse(json['forecast']['forecastday'][0]['day']['maxtemp_c'].toString()) ?? 0.0,
    MinTemp: double.tryParse(json['forecast']['forecastday'][0]['day']['mintemp_c'].toString()) ?? 0.0,
    WeatherCondition: json['forecast']['forecastday'][0]['day']['condition']['text'],
    Sunrise: json['forecast']['forecastday'][0]['astro']['sunrise'],
    Sunset: json['forecast']['forecastday'][0]['astro']['sunset'],
     dailyTemps: dailyTemperatures,
  );
}


  toJson() {}         
}


