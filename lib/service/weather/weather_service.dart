import 'package:gardenesp/model/forecast/forecast.dart';
import 'package:gardenesp/service/weather/weather_api.dart';

abstract class WeatherService {
  Future<Forecast> getWeather(String city);
}

class WeatherServiceImpl extends WeatherService {
  final WeatherApi api;

  WeatherServiceImpl({required this.api});

  @override
  Future<Forecast> getWeather(String city) async {
    final location = await api.getLocation(city);
    return await api.getWeather(location);
  }
}
