import 'package:injectable/injectable.dart';
import 'package:moja_apka/data/remote_data_sources/weather_remote_data_source.dart';
import 'package:moja_apka/domain/model/weather_model.dart';

@injectable
class WeatherRepository {
  WeatherRepository({required this.weatherRemoteDataSource});
  final WeatherRemoteDataSource weatherRemoteDataSource;
  Future<WeatherModel?> getWeatherModel({
    required String city,
  }) async {
    final json = await weatherRemoteDataSource.getWeatherData(
      city: city,
    );

    if (json == null) {
      return null;
    }
    return WeatherModel.fromJson(json);
    
  }
}
