import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gardenesp/blocs/authentication/authentication_bloc.dart';
import 'package:gardenesp/blocs/login/login_cubit.dart';
import 'package:gardenesp/extensions.dart';
import 'package:gardenesp/repository/UserRepository.dart';
import 'package:gardenesp/ui/home_screen.dart';
import 'package:gardenesp/ui/login/login_screen.dart';
import 'package:gardenesp/ui/splash_screen.dart';

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

  _GardenspState() {}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildMaterialApp(Container(
            child: Text("Error: ${snapshot.error.toString()}"),
          ));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildMainApp();
        }
        return _buildMaterialApp(SplashScreen());
      },
    );
  }

  Widget _buildMaterialApp(Widget home) {
    return MaterialApp(
      title: 'Flutter Demo',
      supportedLocales: [
        Locale("en", "US"),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: home,
    );
  }

  Widget _buildMainApp() {
    final _userRepository = UserRepository();
    final _authenticationBloc = AuthenticationBloc(_userRepository);

    _authenticationBloc.add(AppStarted());

    return _buildMaterialApp(RepositoryProvider.value(
      value: _userRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => _authenticationBloc),
          BlocProvider(create: (_) => LoginCubit(_userRepository)),
        ],
        child: BlocBuilder(
          bloc: _authenticationBloc,
          builder: (context, state) {
            if (state is Uninitialized) {
              return SplashScreen();
            }
            if (state is Unauthenticated) {
              return LoginScreen();
            }
            if (state is Authenticated) {
              print(state.user);
              return HomeScreen(name: state.user.name);
            }
            return Container();
          },
        ),
      ),
    ));
  }
}
