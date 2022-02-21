import 'package:gardenesp/model/forecast/forecast.dart';
import 'package:gardenesp/model/forecast/location.dart';

enum WeatherUnit { METRIC, IMPERIAL }

abstract class WeatherApi {
  Future<LatLng> getLocation(String city);

  Future<Forecast> getWeather(LatLng location, WeatherUnit unit);
}
