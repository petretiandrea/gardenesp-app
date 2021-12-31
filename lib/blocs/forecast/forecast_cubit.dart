import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenesp/blocs/forecast/forecast_request.dart';
import 'package:gardenesp/blocs/forecast/forecast_state.dart';
import 'package:gardenesp/model/forecast/location.dart';
import 'package:gardenesp/service/weather/weather_api.dart';
import 'package:gardenesp/service/weather/weather_service.dart';
import 'package:location/location.dart';

abstract class ForecastCubit extends Cubit<ForecastState> {
  ForecastCubit(ForecastState initialState) : super(initialState);

  Future<void> loadForecastByCurrentLocation();

  Future<void> loadForecast(ForecastRequest request);

  Future<void> changeUnitMeasure(WeatherUnit unit);

  Future<void> refresh();
}

class ForecastCubitImpl extends ForecastCubit {
  final WeatherRepository weatherService;
  final Location locationService;

  WeatherUnit _unit = WeatherUnit.METRIC;
  ForecastRequest? _lastRequest;

  ForecastCubitImpl({
    required this.weatherService,
    required this.locationService,
  }) : super(ForecastInitial());

  @override
  Future<void> changeUnitMeasure(WeatherUnit unit) async {
    if (unit != _unit) {
      _unit = unit;
      await refresh();
    }
  }

  @override
  Future<void> loadForecastByCurrentLocation() async {
    final location = await _requestLocation();
    if (location.longitude != null && location.latitude != null) {
      return await loadForecast(
        LocationForecastRequest(
          coordinate: LatLng(
            latitude: location.latitude!,
            longitude: location.longitude!,
          ),
        ),
      );
    }
  }

  @override
  Future<void> loadForecast(ForecastRequest request) async {
    _lastRequest = request;
    if (request is LocationForecastRequest) {
      await _loadForecastByLatLng(request.coordinate, _unit);
    } else if (request is AddressForecastRequest) {
      await _loadForecastByCity(request.address, _unit);
    }
  }

  @override
  Future<void> refresh() async {
    if (_lastRequest != null) {
      await loadForecast(_lastRequest!);
    }
  }

  Future<void> _loadForecastByCity(String city, WeatherUnit unit) async {
    emit(ForecastLoading());
    final newState = await weatherService.getWeather(city, unit).then(
          (value) => ForecastLoaded.fromForecast(
              forecastWithAddress: value, unit: unit),
          onError: (error) => ForecastError(),
        );
    emit(newState);
  }

  Future<void> _loadForecastByLatLng(LatLng latLng, WeatherUnit unit) async {
    emit(ForecastLoading());
    final newState =
        await weatherService.getWeatherByLocation(latLng, unit).then(
              (value) => ForecastLoaded.fromForecast(
                  forecastWithAddress: value, unit: unit),
              onError: (error) => ForecastError(),
            );
    emit(newState);
  }

  Future<LocationData> _requestLocation() async {
    var isEnabled = await locationService.serviceEnabled();
    if (!isEnabled) {
      isEnabled = await locationService.requestService();
    }
    if (isEnabled) {
      var permissionGranted = await locationService.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await locationService.requestPermission();
      }
      if (permissionGranted == PermissionStatus.granted ||
          permissionGranted == PermissionStatus.grantedLimited) {
        return await locationService.getLocation();
      }
      return Future.error("No permission granted");
    }
    return Future.error("No location service enabled");
  }
}
