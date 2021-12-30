import 'package:gardenesp/model/forecast/location.dart';

abstract class Geocoder {
  Future<String> getAddressName(LatLng latLng);
}
