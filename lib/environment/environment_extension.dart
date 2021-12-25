import 'package:gardenesp/environment/environment.dart';

extension EnviromentExtension on Environment {
  String get openWeatherKey => this.getOrElse('OPEN_WEATHER_API_KEY', "");
  String get openWeatherUrl => this.getOrElse(
      'OPEN_WEATHER_URL', "https://api.openweathermap.org/data/2.5/");
}
