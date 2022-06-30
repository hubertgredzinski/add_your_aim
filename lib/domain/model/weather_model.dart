class WeatherModel {
  const WeatherModel({
    required this.condition,
    required this.defraIndex,
    required this.temperature,
    required this.city,
  });
  final String condition;
  final String defraIndex;
  final double temperature;
  final String city;
}
