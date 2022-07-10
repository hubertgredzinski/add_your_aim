import 'package:get_it/get_it.dart';
import 'package:moja_apka/data/remote_data_sources/weather_remote_data_source.dart';
import 'package:moja_apka/domain/repositories/goal_repository.dart';
import 'package:moja_apka/domain/repositories/weather_repository.dart';
import 'package:moja_apka/features/add/pages/cubit/add_cubit.dart';
import 'package:moja_apka/features/home/cubit/home_cubit.dart';
import 'package:moja_apka/features/weather/cubit/weather_cubit.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerFactory(() => HomeCubit(goalRepository: getIt()));
  getIt.registerFactory(() => WeatherCubit(weatherRepository: getIt()));
  getIt.registerFactory(() => AddCubit(goalRepository: getIt()));
  getIt.registerFactory(() => GoalRepository());
  getIt.registerFactory(
      () => WeatherRepository(weatherRemoteDataSource: getIt()));
  getIt.registerFactory(() => WeatherRemoteDataSource());
}
