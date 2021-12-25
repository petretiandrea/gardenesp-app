import 'package:dartz/dartz.dart';
import 'package:gardenesp/list_extensions.dart';
import 'package:gardenesp/model/forecast/location.dart';
import 'package:gardenesp/model/forecast/weather.dart';

class Forecast {
  final DateTime lastUpdated;
  final Location location;
  final IList<Weather> daily;
  final Weather current;
  final bool isDayTime;

  Forecast._({
    required this.lastUpdated,
    required this.location,
    required this.daily,
    required this.current,
    required this.isDayTime,
  });

  static Forecast fromJson(dynamic json) {
    var weather = json['current']['weather'][0];
    var date = DateTime.fromMillisecondsSinceEpoch(json['current']['dt'] * 1000,
        isUtc: true);

    var sunrise = DateTime.fromMillisecondsSinceEpoch(
        json['current']['sunrise'] * 1000,
        isUtc: true);

    var sunset = DateTime.fromMillisecondsSinceEpoch(
        json['current']['sunset'] * 1000,
        isUtc: true);

    bool isDay = date.isAfter(sunrise) && date.isBefore(sunset);

    // get the forecast for the next 3 days, excluding the current day
    bool hasDaily = json['daily'] != null;
    final tempDaily = (hasDaily)
        ? json['daily']
            .map((item) => Weather.fromDailyJson(item))
            .toList()
            .skip(1)
            .take(3)
            .toImmutableList()
        : emptyList();

    var currentForecast = Weather(
        cloudiness: int.parse(json['current']['clouds'].toString()),
        temp: json['current']['temp'].toDouble(),
        condition: Weather.mapStringToWeatherCondition(
            weather['main'], int.parse(json['current']['clouds'].toString())),
        description: weather['description'],
        feelLikeTemp: json['current']['feels_like'],
        date: date);

    return Forecast._(
      lastUpdated: DateTime.now(),
      current: currentForecast,
      location: Location(
        latitude: json['lat'].toDouble(),
        longitude: json['lon'].toDouble(),
      ),
      daily: tempDaily,
      isDayTime: isDay,
    );
  }
}
