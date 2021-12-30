import 'package:flutter/foundation.dart';

@immutable
class LatLng {
  final num latitude;
  final num longitude;

//<editor-fold desc="Data Methods">

  const LatLng({
    required this.latitude,
    required this.longitude,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LatLng &&
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

  LatLng copyWith({
    num? latitude,
    num? longitude,
  }) {
    return LatLng(
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

  factory LatLng.fromMap(Map<String, dynamic> map) {
    return LatLng(
      latitude: map['latitude'] as num,
      longitude: map['longitude'] as num,
    );
  }

//</editor-fold>
}
