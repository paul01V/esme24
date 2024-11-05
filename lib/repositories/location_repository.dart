
import 'dart:ffi';

import 'models/location.dart';

abstract class LocationRepository{
  List<Location> getLocations();
  List<Location> getLocationsFromGPS(Long lat, Long long);
  List<Location> getLocationsFromAddress(String address);
}