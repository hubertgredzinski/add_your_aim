import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moja_apka/app/core/enums.dart';
import 'package:moja_apka/domain/model/weather_model.dart';
import 'package:moja_apka/domain/repositories/weather_repository.dart';
part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({required this.weatherRepository}) : super(const WeatherState());

  final WeatherRepository weatherRepository;

  Future<void> getWeatherModel({
    required String city,
  }) async {
    emit(const WeatherState(status: Status.loading));
    try {
      final weatherModel = await weatherRepository.getWeatherModel(city: city);
      emit(
        WeatherState(
          model: weatherModel,
          status: Status.success,
        ),
      );
    } catch (error) {
      emit(
        WeatherState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
