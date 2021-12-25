import 'dart:convert';

import 'package:gardenesp/model/forecast/forecast.dart';
import 'package:gardenesp/model/forecast/location.dart';
import 'package:http/http.dart';

abstract class WeatherApi {
  Future<Location> getLocation(String city);

  Future<Forecast> getWeather(Location location);
}

class OpenWeatherApi extends WeatherApi {
  final String endpointUrl;
  final String apiKey;
  late final Client http;

  OpenWeatherApi({required this.endpointUrl, required this.apiKey}) {
    this.http = new Client();
  }

  @override
  Future<Forecast> getWeather(Location location) async {
    final requestUrl =
        '$endpointUrl/onecall?lat=${location.latitude}&lon=${location.longitude}&exclude=hourly,minutely&APPID=$apiKey';

    final response = await this.http.get(Uri.parse(Uri.encodeFull(requestUrl)));

    if (response.statusCode != 200) {
      throw Exception('error retrieving weather: ${response.statusCode}');
    }

    return Forecast.fromJson(jsonDecode(response.body));
  }

  @override
  Future<Location> getLocation(String city) async {
    final requestUrl = '$endpointUrl/weather?q=$city&APPID=$apiKey';
    final response = await this.http.get(Uri.parse(Uri.encodeFull(requestUrl)));

    if (response.statusCode != 200) {
      throw Exception(
          'error retrieving location for city $city: ${response.statusCode}');
    }

    final json = jsonDecode(response.body);
    return Location(
      longitude: json['coord']['lon'].toDouble(),
      latitude: json['coord']['lat'].toDouble(),
    );
  }
}
