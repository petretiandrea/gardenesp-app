import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:gardenesp/ui/gardens/garden_create_edit.dart';
import 'package:gardenesp/ui/login/login_screen.dart';
import 'package:gardenesp/ui/main_screen.dart';
import 'package:gardenesp/ui/profile/profile_detail_edit_screen.dart';
import 'package:gardenesp/ui/splash_screen.dart';

typedef RouteBuilder = Widget Function(Map<String, String> params);

class Routes {
  static const SPLASH_SCREEN = "/splash";
  static const LOGIN_SCREEN = "/login";
  static const HOME_SCREEN = "/home";
  static const MAIN_SCREEN = "/main";
  static const SCHEDULE_SCREEN = "/schedule";
  static const GARDEN_CREATE_EDIT_SCREEN = "/garden_create_edit";
  static const PROFILE_DETAIL_EDIT = "/profile_detail_edit";

  static final _router = _Router();

  static Map<String, WidgetBuilder> createRouter() {
    _router.registerRoute(
      path: SPLASH_SCREEN,
      builder: (_) => SplashScreen(),
    );

    _router.registerRoute(
      path: LOGIN_SCREEN,
      builder: (params) => LoginScreen(),
    );

    _router.registerRoute(
      path: PROFILE_DETAIL_EDIT,
      builder: (params) => ProfileDetailEditScreen(),
    );

    _router.registerRoute(
      path: MAIN_SCREEN,
      builder: (params) => MainScreen(),
    );

    _router.registerRoute(
      path: GARDEN_CREATE_EDIT_SCREEN,
      builder: (params) => GardenCreateEditScreen(),
    );

    return _router.createRoutes();
  }
}

class _Router {
  final Map<String, RouteBuilder> _routes = HashMap();

  void registerRoute({
    required String path,
    required RouteBuilder builder,
  }) =>
      _routes[path] = builder;

  Map<String, WidgetBuilder> createRoutes() {
    return _routes.map((key, route) {
      final WidgetBuilder builder = (context) {
        return route(
            ModalRoute.of(context)?.settings.arguments as Map<String, String>);
      };
      return MapEntry(key, builder);
    });
  }
}
