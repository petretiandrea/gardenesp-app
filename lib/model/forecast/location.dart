import 'package:flutter/foundation.dart';

@immutable
class Location {
  final num latitude;
  final num longitude;

//<editor-fold desc="Data Methods">

  const Location({
    required this.latitude,
    required this.longitude,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Location &&
          runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          longitude == other.longitude);

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;

  @override
  String toString() {
    return 'Location{' +
        ' latitude: $latitude,' +
        ' longitude: $longitude,' +
        '}';
  }

  Location copyWith({
    num? latitude,
    num? longitude,
  }) {
    return Location(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': this.latitude,
      'longitude': this.longitude,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      latitude: map['latitude'] as num,
      longitude: map['longitude'] as num,
    );
  }

//</editor-fold>
}
