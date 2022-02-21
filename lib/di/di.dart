import 'package:gardenesp/environment/environment.dart';
import 'package:gardenesp/environment/environment_extension.dart';
import 'package:gardenesp/repository/garden_repository.dart';
import 'package:gardenesp/repository/user_repository.dart';
import 'package:gardenesp/service/geocoding/geocoder.dart';
import 'package:gardenesp/service/weather/weather_api.dart';
import 'package:gardenesp/service/weather/weather_service.dart';
import 'package:get_it/get_it.dart';

final inject = GetIt.instance;

Future<void> initializeDependencyInjection() async {
  // first of all initialize the environment
  final environment = Environment(
    environmentPath: "default.env",
    secretsPath: "real_secrets.env",
  );
  await environment.initialize();
  inject.registerSingleton(environment);

  // services
  final weather = OpenWeatherApi(
    endpointUrl: inject<Environment>().openWeatherUrl,
    apiKey: inject<Environment>().openWeatherKey,
  );
  inject.registerSingleton<WeatherApi>(weather);
  inject.registerSingleton<Geocoder>(weather);

  // repositories
  inject.registerSingleton(UserRepository());
  inject.registerSingleton(GardenRepository());
  inject.registerSingleton(WeatherRepositoryImpl(
    api: inject<WeatherApi>(),
    geocoder: inject<Geocoder>(),
  ));
}
