import 'dart:convert';

import 'package:gardenesp/model/forecast/forecast.dart';
import 'package:gardenesp/model/forecast/location.dart';
import 'package:gardenesp/service/geocoding/geocoder.dart';
import 'package:gardenesp/service/weather/weather_api.dart';
import 'package:http/http.dart';

class HttpOpenWeatherApi extends WeatherApi implements Geocoder {
  final String endpointUrl;
  final String apiKey;
  late final Client http;

  HttpOpenWeatherApi({required this.endpointUrl, required this.apiKey}) {
    this.http = new Client();
  }

  @override
  Future<Forecast> getWeather(LatLng location, WeatherUnit unit) async {
    final endpointAuthority = Uri.parse(endpointUrl).authority;
    final requestUri = Uri.https(endpointAuthority, "/data/2.5/onecall", {
      "lat": "${location.latitude}",
      "lon": "${location.longitude}",
      "exclude": "hourly,minutely",
      "units": unit == WeatherUnit.METRIC ? "metric" : "imperial",
      "APPID": apiKey
    });

    final response = await this.http.get(requestUri);

    if (response.statusCode != 200) {
      throw Exception('error retrieving weather: ${response.statusCode}');
    }

    return Forecast.fromJson(jsonDecode(response.body));
  }

  @override
  Future<LatLng> getLocation(String city) async {
    final requestUrl = '$endpointUrl/data/2.5/weather?q=$city&APPID=$apiKey';
    final response = await this.http.get(Uri.parse(Uri.encodeFull(requestUrl)));

    if (response.statusCode != 200) {
      throw Exception(
          'error retrieving location for city $city: ${response.statusCode}');
    }

    final json = jsonDecode(response.body);
    return LatLng(
      longitude: json['coord']['lon'].toDouble(),
      latitude: json['coord']['lat'].toDouble(),
    );
  }

  @override
  Future<String> getAddressName(LatLng latLng) async {
    final endpointAuthority = Uri.parse(endpointUrl).authority;
    final requestUri = Uri.https(
      endpointAuthority,
      "/geo/1.0/reverse",
      {
        "lat": latLng.latitude.toString(),
        "lon": latLng.longitude.toString(),
        "limit": "1",
        "appid": apiKey
      },
    );
    final response = await this.http.get(requestUri);
    final json = jsonDecode(response.body);
    if (json != null) {
      final jsonAsList = json as List<dynamic>;
      return jsonAsList.length > 0 ? jsonAsList[0]["name"] : "";
    }
    return "";
  }
}
