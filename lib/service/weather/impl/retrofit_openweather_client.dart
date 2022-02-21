import 'package:dio/dio.dart';
import 'package:gardenesp/model/forecast/forecast.dart';
import 'package:retrofit/retrofit.dart';

part 'retrofit_openweather_client.g.dart';

class OpenWeatherLatLng {
  final num latitude;
  final num longitude;

  OpenWeatherLatLng({required this.latitude, required this.longitude});

  static OpenWeatherLatLng fromJson(dynamic json) {
    return OpenWeatherLatLng(
      longitude: json['coord']['lon'].toDouble(),
      latitude: json['coord']['lat'].toDouble(),
    );
  }
}

@RestApi()
abstract class OpenWeatherRetrofitClient {
  factory OpenWeatherRetrofitClient(
    Dio dio, {
    required String baseUrl,
    required String apiKey,
  }) {
    dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) {
        options.queryParameters.putIfAbsent("appid", () => apiKey);
        handler.next(options);
      }),
    );
    return _OpenWeatherRetrofitClient(dio, baseUrl: baseUrl);
  }

  @GET("/data/2.5/weather")
  Future<OpenWeatherLatLng> getLocation(@Query("q") String city);

  @GET("/data/2.5/onecall")
  Future<Forecast> getWeather(
    @Query("lat") num latitude,
    @Query("lon") num longitude,
    @Query("units") String unit, {
    @Query("exclude") String exclude = "hourly,minutely",
  });

  @GET("/geo/1.0/reverse")
  Future<dynamic> getAddressName(
    @Query("lat") num latitude,
    @Query("lon") num longitude, {
    @Query("limit") num limit = 1,
  });
}
