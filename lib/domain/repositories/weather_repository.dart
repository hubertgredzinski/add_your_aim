import 'package:moja_apka/data/remote_data_sources/weather_remote_data_source.dart';
import 'package:moja_apka/domain/model/weather_model.dart';

class WeatherRepository {
  WeatherRepository(this._weatherRemoteDataSource);
  final WeatherRemoteDataSource _weatherRemoteDataSource;
  Future<WeatherModel?> getWeatherModel({
    required String city,
  }) async {
    final json = await _weatherRemoteDataSource.getWeatherData(
      city: city,
    );

    if (json == null) {
      return null;
    }
    return WeatherModel.fromJson(json);
    
  }
}
