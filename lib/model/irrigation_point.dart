import 'package:flutter/foundation.dart';

@immutable
class LocationPoint {
  final num x;
  final num y;

//<editor-fold desc="Data Methods">

  const LocationPoint({
    required this.x,
    required this.y,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationPoint &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y);

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() {
    return 'LocationPoint{' + ' x: $x,' + ' y: $y,' + '}';
  }

  LocationPoint copyWith({
    num? x,
    num? y,
  }) {
    return LocationPoint(
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'x': this.x,
      'y': this.y,
    };
  }

  factory LocationPoint.fromMap(Map<String, dynamic> map) {
    return LocationPoint(
      x: map['x'] as num,
      y: map['y'] as num,
    );
  }

//</editor-fold>
}

@immutable
abstract class IrrigationPoint {
  abstract final LocationPoint location;
}

class SinglePoint extends IrrigationPoint {
  @override
  final LocationPoint location;

//<editor-fold desc="Data Methods">

  SinglePoint({
    required this.location,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SinglePoint &&
          runtimeType == other.runtimeType &&
          location == other.location);

  @override
  int get hashCode => location.hashCode;

  @override
  String toString() {
    return 'SinglePoint{' + ' location: $location,' + '}';
  }

  SinglePoint copyWith({
    LocationPoint? location,
  }) {
    return SinglePoint(
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'location': this.location,
    };
  }

  factory SinglePoint.fromMap(Map<String, dynamic> map) {
    return SinglePoint(
      location: map['location'] as LocationPoint,
    );
  }

//</editor-fold>
}

class Dripping extends IrrigationPoint {
  @override
  final LocationPoint location;

//<editor-fold desc="Data Methods">

  Dripping({
    required this.location,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Dripping &&
          runtimeType == other.runtimeType &&
          location == other.location);

  @override
  int get hashCode => location.hashCode;

  @override
  String toString() {
    return 'Dripping{' + ' location: $location,' + '}';
  }

  Dripping copyWith({
    LocationPoint? location,
  }) {
    return Dripping(
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'location': this.location,
    };
  }

  factory Dripping.fromMap(Map<String, dynamic> map) {
    return Dripping(
      location: map['location'] as LocationPoint,
    );
  }

//</editor-fold>
}
