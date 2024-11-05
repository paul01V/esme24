import 'dart:ffi';

import 'package:swipezone/repositories/location_repository.dart';
import 'package:swipezone/repositories/models/categories.dart';
import 'package:swipezone/repositories/models/localization.dart';
import 'package:swipezone/repositories/models/location.dart';

class ILocationRepository implements LocationRepository{
  @override
  List<Location> getLocations() {
    return [
      Location("nom",
          null,
          null,
          null,
          null,
          Categories.Museum,
          null,
          Localization()),
      Location("nom1",
          null,
          null,
          null,
          null,
          Categories.Museum,
          null,
          Localization()),
      Location("nom2",
          null,
          null,
          null,
          null,
          Categories.Museum,
          null,
          Localization()),
      Location("nom3",
          null,
          null,
          null,
          null,
          Categories.Museum,
          null,
          Localization()),
      Location("nom4",
          null,
          null,
          null,
          null,
          Categories.Museum,
          null,
          Localization()),
    ];
  }

  @override
  List<Location> getLocationsFromAddress(String address) {
    // TODO: implement getLocationsFromAddress
    throw UnimplementedError();
  }

  @override
  List<Location> getLocationsFromGPS(Long lat, Long long) {
    // TODO: implement getLocationsFromGPS
    throw UnimplementedError();
  }


}