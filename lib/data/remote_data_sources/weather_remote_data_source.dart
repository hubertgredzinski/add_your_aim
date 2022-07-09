import 'package:dio/dio.dart';

class WeatherRemoteDataSource {
  Future<Map<String, dynamic>?> getWeatherData({
    required String city,
  }) async {
    try {
      final response = await Dio().get<Map<String, dynamic>>(
          'http://api.weatherapi.com/v1/current.json?key=c7f5e7160a0a4f7291281603223006&q=$city&aqi=yes');
      return response.data;
    } on DioError catch (error) {
      throw Exception(
          error.response?.data['error']['message'] ?? 'Nieznany błąd');
    }
  }
}
