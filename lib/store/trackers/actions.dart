import 'package:yoshipls/models/Tracker.dart';

class AddTrackerAction {
  final Tracker tracker;

  AddTrackerAction(this.tracker);
}

class DeleteTrackerAction {
  final String id;

  DeleteTrackerAction(this.id);
}

class UpdateTrackerAction {
  final String id;
  final Tracker tracker;

  UpdateTrackerAction(this.id, this.tracker);
}
