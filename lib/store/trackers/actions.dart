import 'package:yoshipls/models/tracker.dart';

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
  final int success;
  final int failure;

  UpdateTrackerAction(this.id, this.success, this.failure);
}
