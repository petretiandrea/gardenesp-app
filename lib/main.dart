import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gardenesp/blocs/authentication/authentication_bloc.dart';
import 'package:gardenesp/blocs/login/login_form_cubit.dart';
import 'package:gardenesp/extensions.dart';
import 'package:gardenesp/repository/UserRepository.dart';
import 'package:gardenesp/routes.dart';

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
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  _GardenspState();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(child: Text("Error: ${snapshot.error.toString()}"));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildApp();
        }
        return Container(child: CircularProgressIndicator());
      },
    );
  }

  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  Widget _buildApp() {
    final userRepository = UserRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                AuthenticationBloc(userRepository)..add(AppStarted())),
        BlocProvider(
          create: (context) => LoginFormCubit(
            userRepository,
            context.read<AuthenticationBloc>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        supportedLocales: [
          Locale("en", "US"),
        ],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        navigatorKey: _navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: Routes.createRouter(),
        initialRoute: Routes.SPLASH_SCREEN,
        builder: (context, child) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is Unauthenticated) {
                _navigator.pushNamedAndRemoveUntil(
                    Routes.LOGIN_SCREEN, (route) => false);
              }
              if (state is Authenticated) {
                _navigator.pushNamedAndRemoveUntil(
                  Routes.HOME_SCREEN,
                  (route) => false,
                  arguments: {
                    'user': state.user.name,
                  },
                );
              }
            },
            child: child,
          );
        },
      ),
    );
  }
}
