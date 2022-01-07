import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gardenesp/blocs/forecast/forecast_cubit.dart';
import 'package:gardenesp/blocs/forecast/forecast_state.dart';
import 'package:gardenesp/blocs/resource/resource_cubit.dart';
import 'package:gardenesp/extensions.dart';
import 'package:gardenesp/model/forecast/weather.dart';
import 'package:gardenesp/service/weather/weather_api.dart';
import 'package:gardenesp/string_extensions.dart';
import 'package:gardenesp/ui/forecast/forecast_day_widget.dart';
import 'package:gardenesp/ui/forecast/weather_ui_adapter.dart';
import 'package:gardenesp/widget/refresh_button.dart';
import 'package:intl/intl.dart';

class ForecastCard extends StatefulWidget {
  static const String _FORMAT_DAY_HOUR = "EEE, HH:mm";

  const ForecastCard();

  @override
  State<ForecastCard> createState() => _ForecastCardState();
}

class _ForecastCardState extends State<ForecastCard> {
  @override
  void initState() {
    context.read<ForecastCubitImpl>().loadForecastByCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: BlocBuilder<ForecastCubitImpl, ResourceState<ForecastUiData>>(
        builder: (context, state) {
          return _buildCard(context, state);
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, ResourceState<ForecastUiData> state) {
    final dartz.Option<ForecastUiData> currentForecast =
        state is ResourceLoading<ForecastUiData>
            ? state.value
            : (state is ResourceSuccess<ForecastUiData>
                ? dartz.Some(state.value)
                : dartz.None());

    final gradient = currentForecast.fold(
      () => Theme.of(context).colorScheme.primary,
      (loadedState) => loadedState.forecast.current.getGradientColor(),
    );

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 1.0],
          colors: [
            gradient,
            gradient.lighten(),
          ],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black, Colors.transparent],
            stops: [0.0, 2.0],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Container(
            child: _buildCardContent(state),
          ),
        ),
      ),
    );
  }

  Widget _buildCardContent(ResourceState<ForecastUiData> state) {
    if (state is ResourceSuccess<ForecastUiData>) {
      return _buildCardLoadedWeather(state.value, false);
    } else if (state is ResourceLoading<ForecastUiData> &&
        state.value.isSome()) {
      return _buildCardLoadedWeather(state.value.toNullable()!, true);
    } else {
      return Container(
        alignment: Alignment.center,
        height: 216,
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _buildCardLoadedWeather(
    ForecastUiData data,
    bool isBackgroundLoading,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        _weatherRefresh(context, isBackgroundLoading),
        _weatherHeader(
          context,
          data.forecast.current,
          data.unit,
          data.addressName,
        ),
        SizedBox(
          height: 18,
        ),
        _weatherForecastDays(
          context,
          data.unit,
          data.forecast.daily.toList(),
        ),
      ],
    );
  }

  Widget _weatherRefresh(BuildContext context, bool isLoading) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RefreshButton(
          isLoading: isLoading,
          onClick: () {
            context.read<ForecastCubitImpl>().refresh();
          },
        ),
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
    BuildContext context,
    WeatherUnit unit,
    List<Weather> weathers,
  ) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.spaceAround,
      children: [
        ...weathers
            .map((weatherDay) => ForecastDay.fromWeather(weatherDay, unit))
      ],
    );
  }
}
