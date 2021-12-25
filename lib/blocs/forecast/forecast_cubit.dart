import 'package:dartz/dartz.dart';
import 'package:gardenesp/blocs/resource/resource_cubit.dart';
import 'package:gardenesp/model/forecast/forecast.dart';
import 'package:gardenesp/service/weather/weather_service.dart';

class ForecastCubit extends ResourceCubit<Forecast> {
  final WeatherService weatherService;

  String? currentCity;

  ForecastCubit({required this.weatherService});

  Future<void> loadForecast(String city) async {
    currentCity = city;
    return fetchResource(() {
      return weatherService.getWeather("sdsa").then(
            (value) => left(value),
            onError: (error) => right(error.toString()),
          );
    });
  }

  Future<void> refreshForecast() async {
    if (currentCity != null) {
      return loadForecast(currentCity!);
    } else {
      Future.error("No current city available during refresh");
    }
  }
}
