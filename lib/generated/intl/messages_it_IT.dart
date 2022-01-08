// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it_IT locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'it_IT';

  static String m0(sectors, poi) =>
      "${Intl.plural(sectors, one: '1 settore', other: '${sectors} settori')} - ${poi} PoI";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "garden_card_sectors_poi": m0,
        "navigation_dashboard_label":
            MessageLookupByLibrary.simpleMessage("Dashboard"),
        "navigation_profile_label":
            MessageLookupByLibrary.simpleMessage("Profilo"),
        "navigation_schedule_label":
            MessageLookupByLibrary.simpleMessage("Programmazione"),
        "weather_condition_clear":
            MessageLookupByLibrary.simpleMessage("Soleggiato"),
        "weather_condition_drizzle":
            MessageLookupByLibrary.simpleMessage("Pioggia leggera"),
        "weather_condition_fog": MessageLookupByLibrary.simpleMessage("Nebbia"),
        "weather_condition_heavy_cloud":
            MessageLookupByLibrary.simpleMessage("Nuvoloso"),
        "weather_condition_light_cloud":
            MessageLookupByLibrary.simpleMessage("Parzialmente nuvoloso"),
        "weather_condition_mist":
            MessageLookupByLibrary.simpleMessage("Foschia"),
        "weather_condition_rain":
            MessageLookupByLibrary.simpleMessage("Pioggia"),
        "weather_condition_snow": MessageLookupByLibrary.simpleMessage("Neve"),
        "weather_condition_thunderstorm":
            MessageLookupByLibrary.simpleMessage("Temporale"),
        "weather_condition_unknown":
            MessageLookupByLibrary.simpleMessage("Sconosciuto")
      };
}
