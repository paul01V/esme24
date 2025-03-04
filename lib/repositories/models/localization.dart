import 'package:isar/isar.dart';

@embedded
class Localization {
  final String adress;
  final double latitude;
  final double longitude;

  Localization(this.adress, this.latitude, this.longitude);
}
