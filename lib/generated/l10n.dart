// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Profilo`
  String get navigation_profile_label {
    return Intl.message(
      'Profilo',
      name: 'navigation_profile_label',
      desc: '',
      args: [],
    );
  }

  /// `Programmazione`
  String get navigation_schedule_label {
    return Intl.message(
      'Programmazione',
      name: 'navigation_schedule_label',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get navigation_dashboard_label {
    return Intl.message(
      'Dashboard',
      name: 'navigation_dashboard_label',
      desc: '',
      args: [],
    );
  }

  /// `Thunderstorm`
  String get weather_condition_thunderstorm {
    return Intl.message(
      'Thunderstorm',
      name: 'weather_condition_thunderstorm',
      desc: '',
      args: [],
    );
  }

  /// `Light Rain`
  String get weather_condition_drizzle {
    return Intl.message(
      'Light Rain',
      name: 'weather_condition_drizzle',
      desc: '',
      args: [],
    );
  }

  /// `Rain`
  String get weather_condition_rain {
    return Intl.message(
      'Rain',
      name: 'weather_condition_rain',
      desc: '',
      args: [],
    );
  }

  /// `Snow`
  String get weather_condition_snow {
    return Intl.message(
      'Snow',
      name: 'weather_condition_snow',
      desc: '',
      args: [],
    );
  }

  /// `Mist`
  String get weather_condition_mist {
    return Intl.message(
      'Mist',
      name: 'weather_condition_mist',
      desc: '',
      args: [],
    );
  }

  /// `Fog`
  String get weather_condition_fog {
    return Intl.message(
      'Fog',
      name: 'weather_condition_fog',
      desc: '',
      args: [],
    );
  }

  /// `Light cloud`
  String get weather_condition_light_cloud {
    return Intl.message(
      'Light cloud',
      name: 'weather_condition_light_cloud',
      desc: '',
      args: [],
    );
  }

  /// `Cloudy`
  String get weather_condition_heavy_cloud {
    return Intl.message(
      'Cloudy',
      name: 'weather_condition_heavy_cloud',
      desc: '',
      args: [],
    );
  }

  /// `Sunny`
  String get weather_condition_clear {
    return Intl.message(
      'Sunny',
      name: 'weather_condition_clear',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get weather_condition_unknown {
    return Intl.message(
      'Unknown',
      name: 'weather_condition_unknown',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'it', countryCode: 'IT'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
