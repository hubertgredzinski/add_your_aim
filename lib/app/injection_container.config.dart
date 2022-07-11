// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/remote_data_sources/weather_remote_data_source.dart' as _i5;
import '../domain/repositories/goal_repository.dart' as _i3;
import '../domain/repositories/weather_repository.dart' as _i6;
import '../features/add/pages/cubit/add_cubit.dart' as _i7;
import '../features/home/cubit/home_cubit.dart' as _i4;
import '../features/weather/cubit/weather_cubit.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.GoalRepository>(() => _i3.GoalRepository());
  gh.factory<_i4.HomeCubit>(
      () => _i4.HomeCubit(goalRepository: get<_i3.GoalRepository>()));
  gh.factory<_i5.WeatherRemoteDataSource>(() => _i5.WeatherRemoteDataSource());
  gh.factory<_i6.WeatherRepository>(() => _i6.WeatherRepository(
      weatherRemoteDataSource: get<_i5.WeatherRemoteDataSource>()));
  gh.factory<_i7.AddCubit>(
      () => _i7.AddCubit(goalRepository: get<_i3.GoalRepository>()));
  gh.factory<_i8.WeatherCubit>(
      () => _i8.WeatherCubit(weatherRepository: get<_i6.WeatherRepository>()));
  return get;
}
