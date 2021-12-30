import 'package:gardenesp/model/forecast/forecast.dart';
import 'package:gardenesp/model/forecast/location.dart';
import 'package:gardenesp/service/geocoding/geocoder.dart';
import 'package:gardenesp/service/weather/weather_api.dart';

class ForecastWithAddress {
  final Forecast forecast;
  final String address;

//<editor-fold desc="Data Methods">

  const ForecastWithAddress({
    required this.forecast,
    required this.address,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ForecastWithAddress &&
          runtimeType == other.runtimeType &&
          forecast == other.forecast &&
          address == other.address);

  @override
  int get hashCode => forecast.hashCode ^ address.hashCode;

  @override
  String toString() {
    return 'ForecastWithAddress{' +
        ' forecast: $forecast,' +
        ' address: $address,' +
        '}';
  }

  ForecastWithAddress copyWith({
    Forecast? forecast,
    String? address,
  }) {
    return ForecastWithAddress(
      forecast: forecast ?? this.forecast,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'forecast': this.forecast,
      'address': this.address,
    };
  }

  factory ForecastWithAddress.fromMap(Map<String, dynamic> map) {
    return ForecastWithAddress(
      forecast: map['forecast'] as Forecast,
      address: map['address'] as String,
    );
  }

//</editor-fold>
}

abstract class WeatherRepository {
  Future<ForecastWithAddress> getWeather(String city, WeatherUnit unit);

  Future<ForecastWithAddress> getWeatherByLocation(
      LatLng location, WeatherUnit unit);
}

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherApi api;
  final Geocoder geocoder;

  WeatherRepositoryImpl({
    required this.api,
    required this.geocoder,
  });

  @override
  Future<ForecastWithAddress> getWeather(
    String city,
    WeatherUnit unit,
  ) async {
    final location = await api.getLocation(city);
    return await api
        .getWeather(location, unit)
        .then((value) => ForecastWithAddress(forecast: value, address: city));
  }

  @override
  Future<ForecastWithAddress> getWeatherByLocation(
    LatLng location,
    WeatherUnit unit,
  ) async {
    return geocoder.getAddressName(location).then(
          (address) => api.getWeather(location, unit).then((value) =>
              ForecastWithAddress(forecast: value, address: address)),
        );
  }
}
