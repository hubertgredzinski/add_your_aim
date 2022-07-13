class WeatherModel {
  WeatherModel(
      {required this.temperature,
      required this.location,
      required this.defraIndex});

  final double temperature;
  final String location;
  final int defraIndex;

  WeatherModel.fromJson(Map<String, dynamic> json)
      : temperature = json['current']['temp_c'] + 0.0,
        location = json['location']['name'],
        defraIndex = json['current']['air_quality']['gb-defra-index'];
}
