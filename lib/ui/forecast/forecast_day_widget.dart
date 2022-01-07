import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gardenesp/model/forecast/weather.dart';
import 'package:gardenesp/service/weather/weather_api.dart';
import 'package:gardenesp/string_extensions.dart';
import 'package:gardenesp/ui/forecast/weather_ui_adapter.dart';
import 'package:intl/intl.dart';

class ForecastDay extends StatelessWidget {
  final String day;
  final String weatherConditionImage;
  final String temperature;

  static const String _FORMAT_DAY = "EEE";

  const ForecastDay({
    required this.day,
    required this.weatherConditionImage,
    required this.temperature,
  });

  ForecastDay.fromWeather(Weather weather, WeatherUnit unit)
      : day = DateFormat(_FORMAT_DAY).format(weather.date).capitalize(),
        weatherConditionImage = weather.getConditionImage(),
        temperature = weather.getFormattedTemperature(unit);

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
          temperature,
          style: Theme.of(context).textTheme.bodyText2,
        )
      ],
    );
  }
}
