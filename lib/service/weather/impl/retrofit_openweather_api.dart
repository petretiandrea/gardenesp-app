import 'package:gardenesp/model/forecast/forecast.dart';
import 'package:gardenesp/model/forecast/location.dart';
import 'package:gardenesp/service/geocoding/geocoder.dart';
import 'package:gardenesp/service/weather/impl/retrofit_openweather_client.dart';
import 'package:gardenesp/service/weather/weather_api.dart';

class RetrofitOpenWeatherApi extends WeatherApi implements Geocoder {
  final OpenWeatherRetrofitClient api;
  RetrofitOpenWeatherApi(this.api);

  @override
  Future<String> getAddressName(LatLng latLng) {
    return api
        .getAddressName(latLng.latitude, latLng.longitude)
        .then((value) => value as List<dynamic>)
        .then((value) => value.length > 0 ? value[0]["name"] : "");
  }

  @override
  Future<LatLng> getLocation(String city) {
    return api.getLocation(city).then((value) =>
        LatLng(latitude: value.longitude, longitude: value.longitude));
  }

  @override
  Future<Forecast> getWeather(LatLng location, WeatherUnit unit) {
    return api.getWeather(location.latitude, location.longitude,
        unit == WeatherUnit.METRIC ? "metric" : "imperial");
  }
}
