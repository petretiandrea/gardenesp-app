// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gardenesp/blocs/authentication/authentication_bloc.dart';
import 'package:gardenesp/blocs/login/login_form_cubit.dart';
import 'package:gardenesp/environment/environment.dart';
import 'package:gardenesp/environment/environment_extension.dart';
import 'package:gardenesp/generated/l10n.dart';
import 'package:gardenesp/repository/garden_repository.dart';
import 'package:gardenesp/repository/user_repository.dart';
import 'package:gardenesp/routes.dart';
import 'package:gardenesp/service/weather/weather_api.dart';
import 'package:gardenesp/service/weather/weather_service.dart';
import 'package:gardenesp/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Gardensp());
}

class Gardensp extends StatefulWidget {
  const Gardensp({Key? key}) : super(key: key);

  @override
  _GardenspState createState() => _GardenspState();
}

class _GardenspState extends State<Gardensp> {
  final Environment _environment = Environment(
    environmentPath: "default.env",
    secretsPath: "real_secrets.env",
  );

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  _GardenspState();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization.then((value) => _environment.initialize()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(child: Text("Error: ${snapshot.error.toString()}"));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildApp(_environment);
        }
        return Container(child: CircularProgressIndicator());
      },
    );
  }

  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  Widget _buildApp(Environment environment) {
    final OpenWeatherApi weatherApi = OpenWeatherApi(
      endpointUrl: environment.openWeatherUrl,
      apiKey: environment.openWeatherKey,
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: UserRepository()),
        RepositoryProvider.value(value: GardenRepository()),
        RepositoryProvider.value(value: WeatherServiceImpl(api: weatherApi)),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (ctx) => AuthenticationBloc(ctx.read<UserRepository>())
                ..add(AppStarted())),
          BlocProvider(
            create: (ctx) => LoginFormCubit(
              ctx.read<UserRepository>(),
              ctx.read<AuthenticationBloc>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          navigatorKey: _navigatorKey,
          theme: GardenEspTheme.dark(),
          routes: Routes.createRoutes(),
          initialRoute: Routes.SPLASH_SCREEN,
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is Unauthenticated) {
                  _navigator.pushNamedAndRemoveUntil(
                    Routes.LOGIN_SCREEN,
                    (route) => false,
                  );
                }
                if (state is Authenticated) {
                  _navigator.pushNamedAndRemoveUntil(
                    Routes.MAIN_SCREEN,
                    (route) => false,
                  );
                }
              },
              child: child,
            );
          },
        ),
      ),
    );
  }
}
