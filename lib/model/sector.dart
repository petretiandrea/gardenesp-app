import 'package:flutter/foundation.dart';
import 'package:gardenesp/model/irrigation_point.dart';

@immutable
class Sector {
  final String identifier;
  final String name;
  final num lastUpdateTime;
  final List<IrrigationPoint> points;

//<editor-fold desc="Data Methods">

  const Sector({
    required this.identifier,
    required this.name,
    required this.lastUpdateTime,
    required this.points,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sector &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier &&
          name == other.name &&
          lastUpdateTime == other.lastUpdateTime &&
          points == other.points);

  @override
  int get hashCode =>
      identifier.hashCode ^
      name.hashCode ^
      lastUpdateTime.hashCode ^
      points.hashCode;

  @override
  String toString() {
    return 'Sector{' +
        ' identifier: $identifier,' +
        ' name: $name,' +
        ' lastUpdateTime: $lastUpdateTime,' +
        ' points: $points,' +
        '}';
  }

  Sector copyWith({
    String? identifier,
    String? name,
    num? lastUpdateTime,
    List<IrrigationPoint>? points,
  }) {
    return Sector(
      identifier: identifier ?? this.identifier,
      name: name ?? this.name,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      points: points ?? this.points,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'identifier': this.identifier,
      'name': this.name,
      'lastUpdateTime': this.lastUpdateTime,
      'points': this.points,
    };
  }

  factory Sector.fromMap(Map<String, dynamic> map) {
    return Sector(
      identifier: map['identifier'] as String,
      name: map['name'] as String,
      lastUpdateTime: map['lastUpdateTime'] as num,
      points: map['points'] as List<IrrigationPoint>,
    );
  }

//</editor-fold>
}
