import 'package:gardenesp/model/forecast/location.dart';

abstract class ForecastRequest {}

class LocationForecastRequest extends ForecastRequest {
  final LatLng coordinate;

//<editor-fold desc="Data Methods">
  LocationForecastRequest({
    required this.coordinate,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationForecastRequest &&
          runtimeType == other.runtimeType &&
          coordinate == other.coordinate);

  @override
  int get hashCode => coordinate.hashCode;

  @override
  String toString() {
    return 'LocationForecastRequest{' + ' coordinate: $coordinate,' + '}';
  }

  LocationForecastRequest copyWith({
    LatLng? coordinate,
  }) {
    return LocationForecastRequest(
      coordinate: coordinate ?? this.coordinate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'coordinate': this.coordinate,
    };
  }

  factory LocationForecastRequest.fromMap(Map<String, dynamic> map) {
    return LocationForecastRequest(
      coordinate: map['coordinate'] as LatLng,
    );
  }
//</editor-fold>
}

class AddressForecastRequest extends ForecastRequest {
  final String address;

//<editor-fold desc="Data Methods">
  AddressForecastRequest({
    required this.address,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AddressForecastRequest &&
          runtimeType == other.runtimeType &&
          address == other.address);

  @override
  int get hashCode => address.hashCode;

  @override
  String toString() {
    return 'AddressForecastRequest{' + ' address: $address,' + '}';
  }

  AddressForecastRequest copyWith({
    String? address,
  }) {
    return AddressForecastRequest(
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': this.address,
    };
  }

  factory AddressForecastRequest.fromMap(Map<String, dynamic> map) {
    return AddressForecastRequest(
      address: map['address'] as String,
    );
  }
//</editor-fold>
}
