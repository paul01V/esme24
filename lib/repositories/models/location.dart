import 'package:isar/isar.dart';
import 'package:swipezone/repositories/models/weekly_schedule.dart';

import 'activities.dart';
import 'categories.dart';
import 'contact.dart';
import 'localization.dart';


@collection
class Location {
  Id id = Isar.autoIncrement;

  String nom;
  String? description;
  WeeklySchedule? schedule;
  Contact? contact;
  String? photoUrl;
  @enumerated
  Categories category;
  List<Activities>? activities;
  Localization localization;

  Location(this.nom, this.description, this.schedule, this.contact,
      this.photoUrl, this.category, this.activities, this.localization);
}