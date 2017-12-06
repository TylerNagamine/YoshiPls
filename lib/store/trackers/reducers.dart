import 'package:redux/redux.dart';

import 'package:yoshipls/models/Tracker.dart';
import 'package:yoshipls/store/trackers/actions.dart';

final trackersReducer = combineTypedReducers<List<Tracker>>([
  new ReducerBinding<List<Tracker>, AddTrackerAction>(_addTracker),
  new ReducerBinding<List<Tracker>, DeleteTrackerAction>(_deleteTracker),
  new ReducerBinding<List<Tracker>, UpdateTrackerAction>(_updateTracker),
]);

List<Tracker> _addTracker(List<Tracker> trackers, AddTrackerAction action) {
  return new List.from(trackers)..add(action.tracker);
}

List<Tracker> _deleteTracker(List<Tracker> trackers, DeleteTrackerAction action) {
  return trackers.where((tracker) => tracker.id != action.id);
}

List<Tracker> _updateTracker(List<Tracker> trackers, UpdateTrackerAction action) {
  var stateCopy = new List.from(trackers);

  for (var i = 0; i < stateCopy.length; i++) {
    var tracker = stateCopy[i];

    if (tracker.id == action.id) {
      var newTracker = new Tracker.from(tracker);
      newTracker.successes = action.success;
      newTracker.failures = action.failure;
      stateCopy[i] = newTracker;
      break;
    }
  }

  return stateCopy;
}
