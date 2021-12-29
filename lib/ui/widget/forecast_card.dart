import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gardenesp/model/forecast/weather.dart';
import 'package:gardenesp/string_extensions.dart';
import 'package:intl/intl.dart';

extension WeatherUIAdapter on Weather {
  bool isNight() {
    return false;
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
}

class ForecastCard extends StatelessWidget {
  final num degree;
  final String locationName;
  final String dayHour;
  final String weatherCondition;
  final String weatherConditionImage;
  final void Function() onRefresh;

  static const String _FORMAT_DAY_HOUR = "EEE, HH:mm";

  const ForecastCard({
    required this.degree,
    required this.locationName,
    required this.dayHour,
    required this.weatherCondition,
    required this.weatherConditionImage,
    required this.onRefresh,
  });

  ForecastCard.fromWeather({
    required Weather weather,
    required this.locationName,
    required this.onRefresh,
  })  : degree = weather.temperature,
        weatherCondition = weather.getLocalizedCondition(),
        weatherConditionImage = weather.getConditionImage(),
        dayHour = DateFormat(_FORMAT_DAY_HOUR).format(weather.date);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.deepOrange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            _weatherRefresh(context),
            _weatherHeader(context),
          ],
        ),
      ),
    );
  }

  Widget _weatherRefresh(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          child: Icon(
            Icons.sync,
            size: 15,
            color: Colors.white,
          ),
          customBorder: CircleBorder(),
          onTap: () {},
        )
      ],
    );
  }

  Widget _weatherHeader(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          weatherConditionImage,
          width: 90,
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${degree.toStringAsFixed(1)}\u00B0",
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  locationName,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(height: 6),
                Text(
                  "$dayHour, $weatherCondition".capitalize(),
                  style: Theme.of(context).textTheme.bodyText2,
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _weatherForecastDays(BuildContext context, List<Weather> weathers) {
    return Row(
      children: [
        ...weathers.map((weatherDay) => ForecastDay(
              day: "Mar",
              weatherConditionImage: weatherDay.getConditionImage(),
              temperature: weatherDay.temperature,
            ))
      ],
    );
  }
}

class ForecastDay extends StatelessWidget {
  final String day;
  final String weatherConditionImage;
  final num temperature;

  const ForecastDay({
    required this.day,
    required this.weatherConditionImage,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          day,
          style: Theme.of(context).textTheme.headline3,
        ),
        SvgPicture.asset(
          weatherConditionImage,
          width: 36,
        ),
        Text(
          temperature.toStringAsFixed(1),
          style: Theme.of(context).textTheme.bodyText2,
        )
      ],
    );
  }
}
