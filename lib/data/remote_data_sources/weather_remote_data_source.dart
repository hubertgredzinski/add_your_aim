import 'package:dio/dio.dart';

class WeatherRemoteDataSource {
  Future<Map<String,dynamic>?> getWeatherData({
    required String city,
  }) async {

    final response = await Dio().get<Map<String, dynamic>>(
        'http://api.weatherapi.com/v1/current.json?key=c7f5e7160a0a4f7291281603223006&q=$city&aqi=yes');
    return response.data;

    // if (responseData == null) {return null;}

    //   final name = responseData['location']['name'] as String;
    //   final temperature = (responseData['current']['temp_c'] + 0.0) as double;
    //   final airQuality = responseData['current']['air_quality']['gb-defra-index'] as int;
    // return  WeatherModel(
    //   city: name,
    //   defraIndex: airQuality,
    //   temperature: temperature,
    // );
  }
}
