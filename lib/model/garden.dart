import 'package:flutter/widgets.dart';

@immutable
class Garden {
  final String identifier;
  final String name;
  final String description;
  final num lastUpdateTime;
  final String image;

//<editor-fold desc="Data Methods" defaultstate="collapsed">
  const Garden({
    required this.identifier,
    required this.name,
    required this.description,
    required this.lastUpdateTime,
    required this.image,
  });

  Garden copyWith({
    String? identifier,
    String? name,
    String? description,
    num? lastUpdateTime,
    String? image,
  }) {
    return Garden(
      identifier: identifier ?? this.identifier,
      name: name ?? this.name,
      description: description ?? this.description,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      image: image ?? this.image,
    );
  }

  @override
  String toString() {
    return 'Garden{identifier: $identifier, name: $name, description: $description, lastUpdateTime: $lastUpdateTime}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Garden &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier &&
          name == other.name &&
          description == other.description &&
          lastUpdateTime == other.lastUpdateTime &&
          image == other.image);

  @override
  int get hashCode =>
      identifier.hashCode ^
      name.hashCode ^
      description.hashCode ^
      lastUpdateTime.hashCode ^
      image.hashCode;

  factory Garden.fromMap(Map<String, dynamic> map) {
    return Garden(
      identifier: map['identifier'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      lastUpdateTime: map['lastUpdateTime'] as num,
      image: map['image'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'identifier': this.identifier,
      'name': this.name,
      'description': this.description,
      'lastUpdateTime': this.lastUpdateTime,
      'image': this.image,
    } as Map<String, dynamic>;
  }

//</editor-fold>
}
