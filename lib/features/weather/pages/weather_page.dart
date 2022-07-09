import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moja_apka/core/enums.dart';
import 'package:moja_apka/data/remote_data_sources/weather_remote_data_source.dart';
import 'package:moja_apka/domain/model/weather_model.dart';
import 'package:moja_apka/domain/repositories/weather_repository.dart';
import 'package:moja_apka/features/weather/cubit/weather_cubit.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => WeatherCubit(
              WeatherRepository(WeatherRemoteDataSource()),
            ),
        child: BlocConsumer<WeatherCubit, WeatherState>(
            listener: (context, state) {
          if (state.status == Status.error) {
            final errorMessage = state.errorMessage ?? 'Nieznany błąd';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
         builder: (context, state) {
          final weatherModel = state.model;
          return Scaffold(
            body: Center(
              child: Builder(builder: (context) {
                if (state.status == Status.loading) {
                  return const Text('Loading');
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (weatherModel != null)
                      _DisplayWeatherWidget(
                        weatherModel: weatherModel,
                      ),
                    _SearchWidget(),
                  ],
                );
              }),
            ),
          );
        }));
  }
}

class _DisplayWeatherWidget extends StatelessWidget {
  const _DisplayWeatherWidget({
    Key? key,
    required this.weatherModel,
  }) : super(key: key);

  final WeatherModel weatherModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Column(
              children: [
                Text(
                  weatherModel.location.toString(),
                  style: GoogleFonts.acme(
                      fontSize: 65, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Temperatura: ',
                      style: GoogleFonts.lato(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      weatherModel.temperature.toString(),
                      style: GoogleFonts.lato(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Index defra: ',
                      style: GoogleFonts.lato(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      weatherModel.defraIndex.toString(),
                      style: GoogleFonts.lato(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ));
      },
    );
  }
}

class _SearchWidget extends StatelessWidget {
  _SearchWidget({
    Key? key,
  }) : super(key: key);

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Miasto'),
                hintText: 'Wałbrzych',
              ),
            ),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: () {
              context
                  .read<WeatherCubit>()
                  .getWeatherModel(city: _controller.text);
            },
            child: const Text('Sprawdź'),
          ),
        ],
      ),
    );
  }
}
