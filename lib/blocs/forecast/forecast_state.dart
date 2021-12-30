import 'package:flutter/cupertino.dart';
import 'package:gardenesp/model/forecast/location.dart';
import 'package:gardenesp/service/weather/weather_api.dart';
import 'package:gardenesp/service/weather/weather_service.dart';

@immutable
class ForecastState {
  final ForecastWithAddress forecast;
  final WeatherUnit unit;
  final LatLng? locationCoordinate;

//<editor-fold desc="Data Methods">

  const ForecastState({
    required this.forecast,
    required this.unit,
    this.locationCoordinate,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ForecastState &&
          runtimeType == other.runtimeType &&
          forecast == other.forecast &&
          unit == other.unit &&
          locationCoordinate == other.locationCoordinate);

  @override
  int get hashCode =>
      forecast.hashCode ^ unit.hashCode ^ locationCoordinate.hashCode;

  @override
  String toString() {
    return 'ForecastState{' +
        ' forecast: $forecast,' +
        ' unit: $unit,' +
        ' locationCoordinate: $locationCoordinate,' +
        '}';
  }

  ForecastState copyWith({
    ForecastWithAddress? forecast,
    WeatherUnit? unit,
    LatLng? locationCoordinate,
  }) {
    return ForecastState(
      forecast: forecast ?? this.forecast,
      unit: unit ?? this.unit,
      locationCoordinate: locationCoordinate ?? this.locationCoordinate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'forecast': this.forecast,
      'unit': this.unit,
      'locationCoordinate': this.locationCoordinate,
    };
  }

  factory ForecastState.fromMap(Map<String, dynamic> map) {
    return ForecastState(
      forecast: map['forecast'] as ForecastWithAddress,
      unit: map['unit'] as WeatherUnit,
      locationCoordinate: map['locationCoordinate'] as LatLng,
    );
  }

//</editor-fold>
}
