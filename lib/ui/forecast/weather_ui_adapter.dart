import 'package:flutter/material.dart';
import 'package:gardenesp/model/forecast/weather.dart';
import 'package:gardenesp/service/weather/weather_api.dart';

extension WeatherUIAdapter on Weather {
  bool isNight() {
    return false;
  }

  String getFormattedTemperature(WeatherUnit unit) {
    final symbol = unit == WeatherUnit.METRIC ? "\u2103" : "\u2109";
    return "${temperature.toStringAsFixed(1)}$symbol";
  }

  String getConditionImage() {
    final basePath = "assets/weather_icons";
    switch (this.condition) {
      case WeatherCondition.thunderstorm:
        return "$basePath/thunderstorm-showers.svg";
      case WeatherCondition.mist:
      case WeatherCondition.drizzle:
        return "$basePath/showers.svg";
      case WeatherCondition.rain:
        return "$basePath/heavy-showers.svg";
      case WeatherCondition.snow:
        return "$basePath/heavy-snow.svg";
      case WeatherCondition.atmosphere:
      case WeatherCondition.fog:
        return "$basePath/fog.svg";
      case WeatherCondition.lightCloud:
        return isNight()
            ? "$basePath/partly-cloudy-night.svg"
            : "$basePath/partly-cloudy-day.svg";
      case WeatherCondition.heavyCloud:
        return "$basePath/cloudy.svg";
      case WeatherCondition.clear:
        return isNight()
            ? "$basePath/clear-night.svg"
            : "$basePath/clear-day.svg";
      case WeatherCondition.unknown:
        return ""; // TODO: add unknown image weather
    }
  }

  String getLocalizedCondition() {
    return "Cloudy";
  }

  // begin: Alignment.topLeft,
  // end: Alignment.bottomRight,
  // stops: [0, 1.0],
  // colors: [
  // color[800],
  // color[400],
  // ],
  // ),
  MaterialColor getGradientColor() {
    if (isNight()) {
      return Colors.blueGrey;
    } else {
      switch (condition) {
        case WeatherCondition.thunderstorm:
          return Colors.deepPurple;
        case WeatherCondition.snow:
          return Colors.lightBlue;
        case WeatherCondition.atmosphere:
        case WeatherCondition.fog:
        case WeatherCondition.rain:
        case WeatherCondition.drizzle:
        case WeatherCondition.mist:
        case WeatherCondition.heavyCloud:
          return Colors.indigo;
        case WeatherCondition.clear:
        case WeatherCondition.lightCloud:
          return Colors.yellow;
        case WeatherCondition.unknown:
          return Colors.lightBlue;
      }
    }
  }
}
