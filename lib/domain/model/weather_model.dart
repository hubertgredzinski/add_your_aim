import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class WeatherModel {
  WeatherModel({
    required this.temperature,
  });
  final double temperature;

  WeatherModel.fromJson(Map<String, dynamic> json)
      : temperature = json['current']['temp_c'] + 0.0;
}
