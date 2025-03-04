import 'package:swipezone/repositories/models/location.dart';

class LocationManager {
  static final LocationManager _instance = LocationManager._internal();

  LocationManager._internal();

  factory LocationManager() {
    return _instance;
  }

  List<Location> locations = [];
  List<Location> unwantedLocations = [];
  Map<Location, bool> filters = {};

  int currentIndex = 0;

  void Iwant() {
    filters[locations[currentIndex]] = true;  // Changed to true
    next();
  }

  void Idontwant() {
    unwantedLocations.add(locations[currentIndex]);
    next();
  }

  void next() {
    if (currentIndex < locations.length - 1) {
      currentIndex++;
    }
  }

  void reset() {
    currentIndex = 0;
    unwantedLocations.clear();
    filters.clear();
  }

  bool get isFinished => currentIndex >= locations.length - 1;
}

