import 'package:dartz/dartz.dart';
import 'package:gardenesp/blocs/resource/resource_cubit.dart';
import 'package:gardenesp/model/forecast/forecast.dart';
import 'package:gardenesp/model/forecast/location.dart';
import 'package:gardenesp/service/weather/weather_api.dart';
import 'package:gardenesp/service/weather/weather_service.dart';

class ForecastCubit extends ResourceCubit<Forecast> {
  final WeatherService weatherService;

  String? currentCity;
  WeatherUnit currentWeatherUnit = WeatherUnit.METRIC;

  ForecastCubit({required this.weatherService});

  Future<void> changeMeasureUnits(WeatherUnit unit) async {
    if (currentWeatherUnit != unit) {
      currentWeatherUnit = unit;
      refreshForecast();
    }
    return Future.value();
  }

  Future<void> loadForecast(Location location) async {
    return fetchResource(() {
      return weatherService
          .getWeatherByLocation(location, currentWeatherUnit)
          .then(
            (value) => left(value),
            onError: (error) => right(error.toString()),
          );
    });
  }

  Future<void> loadForecastByCity(String city) async {
    currentCity = city;
    return fetchResource(() {
      return weatherService.getWeather(city, currentWeatherUnit).then(
            (value) => left(value),
            onError: (error) => right(error.toString()),
          );
    });
  }

  Future<void> refreshForecast() async {
    if (currentCity != null) {
      return loadForecastByCity(currentCity!);
    } else {
      Future.error("No current city available during refresh");
    }
  }
}
