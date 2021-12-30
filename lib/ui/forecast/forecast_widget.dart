import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenesp/blocs/forecast/forecast_cubit.dart';
import 'package:gardenesp/blocs/forecast/forecast_state.dart';
import 'package:gardenesp/blocs/resource/resource_cubit.dart';
import 'package:gardenesp/ui/widget/forecast_card.dart';

class ForecastWidget extends StatefulWidget {
  @override
  State<ForecastWidget> createState() => _ForecastWidgetState();
}

class _ForecastWidgetState extends State<ForecastWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ForecastCubitImpl>().loadForecastByCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForecastCubitImpl, ResourceState<ForecastState>>(
      builder: (context, state) {
        if (state is ResourceSuccess<ForecastState>) {
          return ForecastCard.fromWeather(
            weather: state.value.forecast.forecast.current,
            locationName: state.value.forecast.address,
            isLoading: true,
            onRefresh: () {
              context.read<ForecastCubitImpl>().refresh();
            },
          );
        } else {
          return Text("Weather loading...");
        }
      },
    );
  }
}
