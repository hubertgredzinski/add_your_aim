
import 'package:moja_apka/domain/model/weather_model.dart';

class WeatherRepository {
  Future<WeatherModel?> getWeatherModel({
    required String city,
  }) async {
    return const WeatherModel(city: 'Warsaw', condition: 'sunny', defraIndex: '1' , temperature: -5.5, );
  }
}
