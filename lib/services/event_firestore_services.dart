import 'package:screens_ui/models/app_event.dart';
import 'package:firebase_helpers/firebase_helpers.dart';

final eventDBS = DatabaseService<AppEvent>(
  AppDBConstants.eventsCollection,
  fromDS: (id, data) => AppEvent.fromDS(id, data),
  toMap: (event) => event.toMap(),
);

final scheduleDBS = DatabaseService<AppEvent>(
  AppDBConstants.scheduleCollection,
  fromDS: (id, data) => AppEvent.fromDS(id, data),
  toMap: (event) => event.toMap(),
);

class AppDBConstants {
  static const String eventsCollection = "events";
  static const String scheduleCollection = "schedule";
}
