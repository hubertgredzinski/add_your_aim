import 'package:moja_apka/data/remote_data_sources/weather_remote_data_source.dart';
import 'package:moja_apka/domain/model/weather_model.dart';

class WeatherRepository {
  WeatherRepository(this._weatherRemoteDataSource);
  final WeatherRemoteDataSource _weatherRemoteDataSource;
  Future<WeatherModel?> getWeatherModel({
    required String city,
  }) async {
    final responseData = await _weatherRemoteDataSource.getWeatherData(
      city: city,
    );

    if (responseData == null) {
      return null;
    }

    final name = responseData['location']['name'] as String;
    final temperature = (responseData['current']['temp_c'] + 0.0) as double;
    final airQuality =
        responseData['current']['air_quality']['gb-defra-index'] as int;
    return WeatherModel(
      city: name,
      defraIndex: airQuality,
      temperature: temperature,
    );
  }
}
