import 'package:gardenesp/model/forecast/forecast.dart';
import 'package:gardenesp/model/forecast/location.dart';
import 'package:gardenesp/service/weather/weather_api.dart';
import 'package:gardenesp/service/weather/weather_service.dart';

class ForecastUiData {
  final Forecast forecast;
  final WeatherUnit unit;
  final String addressName;
  final LatLng? coordinates;

  const ForecastUiData({
    required this.forecast,
    required this.unit,
    required this.addressName,
    this.coordinates,
  });

  ForecastUiData.fromForecast({
    required ForecastWithAddress forecastWithAddress,
    required WeatherUnit unit,
  })  : forecast = forecastWithAddress.forecast,
        unit = unit,
        addressName = forecastWithAddress.address,
        coordinates = forecastWithAddress.forecast.location;
}
