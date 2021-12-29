import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenesp/blocs/forecast/forecast_cubit.dart';
import 'package:gardenesp/blocs/resource/resource_cubit.dart';
import 'package:gardenesp/model/forecast/forecast.dart';
import 'package:gardenesp/model/forecast/location.dart' as ForecastLocation;
import 'package:location/location.dart';

class ForecastWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LocationProviderWidget(
      builder: (ctx, error, location) {
        final loc = ForecastLocation.Location(
          latitude: location?.latitude ?? 0,
          longitude: location?.longitude ?? 0,
        );
        ctx.read<ForecastCubit>().loadForecast(loc);
        return BlocBuilder<ForecastCubit, ResourceState<Forecast>>(
          builder: (context, state) {
            if (state is ResourceSuccess<Forecast>) {
              return Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadiusDirectional.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(state.value.current.condition.toString()),
                      Text(state.value.current.date.toString())
                    ],
                  ),
                ),
              );
            } else {
              return Text("Weather loading...");
            }
          },
        );
      },
    );
  }
}

class LocationProviderWidget extends StatefulWidget {
  final bool listen;
  final Widget Function(
      BuildContext context, String error, LocationData? location) builder;

  LocationProviderWidget({
    this.listen = false,
    required this.builder,
  });

  @override
  State<LocationProviderWidget> createState() => _LocationProviderWidgetState();
}

class _LocationProviderWidgetState extends State<LocationProviderWidget> {
  final Location _location = Location();

  Future<LocationData> enableLocationService() async {
    var isEnabled = await _location.serviceEnabled();
    if (!isEnabled) {
      isEnabled = await _location.requestService();
      if (isEnabled) {
        var permissionGranted = await _location.hasPermission();
        if (permissionGranted == PermissionStatus.denied) {
          permissionGranted = await _location.requestPermission();
          if (permissionGranted == PermissionStatus.granted ||
              permissionGranted == PermissionStatus.grantedLimited) {
            return await _location.getLocation();
          }
          return Future.error("No permission granted");
        }
        return Future.error("No location service enabled");
      }
    }
    return Future.error("No location permission or service enabled");
  }

  @override
  Widget build(BuildContext context) {
    final locationServiceFuture = enableLocationService();

    return FutureBuilder(
      future: locationServiceFuture,
      builder: (context, currentLocationSnapshot) {
        if (!currentLocationSnapshot.hasError) {
          final currentLocation = currentLocationSnapshot.data as LocationData;
          return widget.builder(context, "", currentLocation);
        } else {
          final error = currentLocationSnapshot.error as String;
          return widget.builder(context, error, null);
        }
      },
    );
  }
}
