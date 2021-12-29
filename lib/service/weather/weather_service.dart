import 'package:gardenesp/model/forecast/forecast.dart';
import 'package:gardenesp/model/forecast/location.dart';
import 'package:gardenesp/service/weather/weather_api.dart';

abstract class WeatherService {
  Future<Forecast> getWeather(String city, WeatherUnit unit);
  Future<Forecast> getWeatherByLocation(Location location, WeatherUnit unit);
}

class WeatherServiceImpl extends WeatherService {
  final WeatherApi api;

  WeatherServiceImpl({required this.api});

  @override
  Future<Forecast> getWeather(String city, WeatherUnit unit) async {
    final location = await api.getLocation(city);
    return await api.getWeather(location, unit);
  }

  @override
  Future<Forecast> getWeatherByLocation(
      Location location, WeatherUnit unit) async {
    return await api.getWeather(location, unit);
  }
}
