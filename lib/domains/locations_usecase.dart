import 'package:swipezone/repositories/location_repository_implementation.dart';
import 'package:swipezone/repositories/models/location.dart';

class LocationUseCase{

  List<Location> getLocation(){

    return ILocationRepository().getLocations();

  }
}