import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gardenesp/blocs/forecast/forecast_cubit.dart';
import 'package:gardenesp/blocs/forecast/forecast_state.dart';
import 'package:gardenesp/extensions.dart';
import 'package:gardenesp/model/forecast/weather.dart';
import 'package:gardenesp/service/weather/weather_api.dart';
import 'package:gardenesp/string_extensions.dart';
import 'package:gardenesp/ui/forecast/weather_ui_adapter.dart';
import 'package:intl/intl.dart';

class ForecastCard extends StatefulWidget {
  static const String _FORMAT_DAY_HOUR = "EEE, HH:mm";

  const ForecastCard();

  @override
  State<ForecastCard> createState() => _ForecastCardState();
}

class _ForecastCardState extends State<ForecastCard> {
  late Color _backgroundColor;

  @override
  void initState() {
    context.read<ForecastCubitImpl>().loadForecastByCurrentLocation();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _backgroundColor = Theme.of(context).colorScheme.primary;
    return Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0],
              colors: [
                _backgroundColor,
                _backgroundColor.lighten(),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              child: BlocBuilder<ForecastCubitImpl, ForecastState>(
                builder: (context, state) {
                  if (state is ForecastLoaded) {
                    //cardGradient = state.forecast.current.getGradientColor();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _weatherRefresh(context),
                        _weatherHeader(
                          context,
                          state.forecast.current,
                          state.unit,
                          state.addressName,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        _weatherForecastDays(
                          context,
                          state.unit,
                          state.forecast.daily.toList(),
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ));
  }

  Widget _weatherRefresh(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.sync,
              size: 15,
              color: Colors.white,
            ),
          ),
          customBorder: CircleBorder(),
          onTap: () {
            context.read<ForecastCubitImpl>().refresh();
          },
        )
      ],
    );
  }

  Widget _weatherHeader(
    BuildContext context,
    Weather current,
    WeatherUnit unit,
    String locationName,
  ) {
    final dayHour =
        DateFormat(ForecastCard._FORMAT_DAY_HOUR).format(current.date);
    final weatherCondition = current.getLocalizedCondition();
    return Row(
      children: [
        SvgPicture.asset(
          current.getConditionImage(),
          width: 90,
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              current.getFormattedTemperature(unit),
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

  Widget _weatherForecastDays(
      BuildContext context, WeatherUnit unit, List<Weather> weathers) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.spaceAround,
      children: [
        ...weathers
            .map((weatherDay) => ForecastDay.fromWeather(weatherDay, unit))
      ],
    );
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     ...weathers.map((weatherDay) => ForecastDay(
    //           day: "Mar",
    //           weatherConditionImage: weatherDay.getConditionImage(),
    //           temperature: weatherDay.temperature,
    //         ))
    //   ],
    // );
  }
}

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
