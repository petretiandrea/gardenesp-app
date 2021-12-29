import 'package:gardenesp/extensions.dart';

enum WeatherCondition {
  thunderstorm,
  drizzle,
  rain,
  snow,
  atmosphere, // dust, ash, fog, sand etc.
  mist,
  fog,
  lightCloud,
  heavyCloud,
  clear,
  unknown
}

class Weather {
  final WeatherCondition condition;
  final String description;
  final double temperature;
  final double feelLikeTemp;
  final int cloudiness;
  final DateTime date;

  static Weather fromDailyJson(dynamic daily) {
    var cloudiness = daily['clouds'];
    var weather = daily['weather'][0];

    return Weather(
        condition: mapStringToWeatherCondition(weather['main'], cloudiness),
        description: (weather['description'] as String).toTitleCase(),
        cloudiness: cloudiness,
        temperature: daily['temp']['day'].toDouble(),
        date: DateTime.fromMillisecondsSinceEpoch(daily['dt'] * 1000,
            isUtc: true),
        feelLikeTemp: daily['feels_like']['day'].toDouble());
  }

  static WeatherCondition mapStringToWeatherCondition(
      String input, int cloudiness) {
    WeatherCondition condition;
    switch (input) {
      case 'Thunderstorm':
        condition = WeatherCondition.thunderstorm;
        break;
      case 'Drizzle':
        condition = WeatherCondition.drizzle;
        break;
      case 'Rain':
        condition = WeatherCondition.rain;
        break;
      case 'Snow':
        condition = WeatherCondition.snow;
        break;
      case 'Clear':
        condition = WeatherCondition.clear;
        break;
      case 'Clouds':
        condition = (cloudiness >= 85)
            ? WeatherCondition.heavyCloud
            : WeatherCondition.lightCloud;
        break;
      case 'Mist':
        condition = WeatherCondition.mist;
        break;
      case 'fog':
        condition = WeatherCondition.fog;
        break;
      case 'Smoke':
      case 'Haze':
      case 'Dust':
      case 'Sand':
      case 'Ash':
      case 'Squall':
      case 'Tornado':
        condition = WeatherCondition.atmosphere;
        break;
      default:
        condition = WeatherCondition.unknown;
    }

    return condition;
  }

//<editor-fold desc="Data Methods">

  const Weather({
    required this.condition,
    required this.description,
    required this.temperature,
    required this.feelLikeTemp,
    required this.cloudiness,
    required this.date,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Weather &&
          runtimeType == other.runtimeType &&
          condition == other.condition &&
          description == other.description &&
          temperature == other.temperature &&
          feelLikeTemp == other.feelLikeTemp &&
          cloudiness == other.cloudiness &&
          date == other.date);

  @override
  int get hashCode =>
      condition.hashCode ^
      description.hashCode ^
      temperature.hashCode ^
      feelLikeTemp.hashCode ^
      cloudiness.hashCode ^
      date.hashCode;

  @override
  String toString() {
    return 'Weather{' +
        ' condition: $condition,' +
        ' description: $description,' +
        ' temp: $temperature,' +
        ' feelLikeTemp: $feelLikeTemp,' +
        ' cloudiness: $cloudiness,' +
        ' date: $date,' +
        '}';
  }

  Weather copyWith({
    WeatherCondition? condition,
    String? description,
    double? temp,
    double? feelLikeTemp,
    int? cloudiness,
    DateTime? date,
  }) {
    return Weather(
      condition: condition ?? this.condition,
      description: description ?? this.description,
      temperature: temp ?? this.temperature,
      feelLikeTemp: feelLikeTemp ?? this.feelLikeTemp,
      cloudiness: cloudiness ?? this.cloudiness,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'condition': this.condition,
      'description': this.description,
      'temp': this.temperature,
      'feelLikeTemp': this.feelLikeTemp,
      'cloudiness': this.cloudiness,
      'date': this.date,
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      condition: map['condition'] as WeatherCondition,
      description: map['description'] as String,
      temperature: map['temp'] as double,
      feelLikeTemp: map['feelLikeTemp'] as double,
      cloudiness: map['cloudiness'] as int,
      date: map['date'] as DateTime,
    );
  }

//</editor-fold>
}
