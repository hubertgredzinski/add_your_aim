class WeatherModel {
  const WeatherModel({
    required this.temperature,
    required this.city,
    required this.defraIndex,
  });

  final double temperature;
  final String city;
  final int defraIndex;

  WeatherModel.fromJson(Map<String, dynamic> json)
      : temperature = json['current']['temp_c'] + 0.0,
        city = json['location']['name'],
        defraIndex = json['current']['air_quality']['gb-defra-index'];
}
