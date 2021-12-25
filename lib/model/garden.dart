import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:gardenesp/list_extensions.dart';
import 'package:gardenesp/model/sector.dart';

@immutable
class Garden {
  final String identifier;
  final String name;
  final String description;
  final String image;
  final IList<Sector> sectors;

  num get lastUpdateTime => sectors
      .sortBy((s1, s2) => s1.lastUpdateTime.compareTo(s2.lastUpdateTime))
      .headOption
      .fold(() => 0, (_) => _.lastUpdateTime);

//<editor-fold desc="Data Methods">

  const Garden({
    required this.identifier,
    required this.name,
    required this.description,
    required this.image,
    required this.sectors,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Garden &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier &&
          name == other.name &&
          description == other.description &&
          image == other.image &&
          sectors == other.sectors);

  @override
  int get hashCode =>
      identifier.hashCode ^
      name.hashCode ^
      description.hashCode ^
      image.hashCode ^
      sectors.hashCode;

  @override
  String toString() {
    return 'Garden{' +
        ' identifier: $identifier,' +
        ' name: $name,' +
        ' description: $description,' +
        ' image: $image,' +
        ' sectors: $sectors,' +
        '}';
  }

  Garden copyWith({
    String? identifier,
    String? name,
    String? description,
    String? image,
    IList<Sector>? sectors,
  }) {
    return Garden(
      identifier: identifier ?? this.identifier,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      sectors: sectors ?? this.sectors,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'identifier': this.identifier,
      'name': this.name,
      'description': this.description,
      'image': this.image,
      'sectors': this.sectors,
    };
  }

  factory Garden.fromMap(Map<String, dynamic> map) {
    return Garden(
      identifier: map['identifier'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      sectors: map['sectors'] as IList<Sector>,
    );
  }

//</editor-fold>
}
