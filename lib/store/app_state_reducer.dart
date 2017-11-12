import 'package:yoshipls/store/app_state.dart';
import 'package:yoshipls/store/trackers/reducers.dart';
import 'package:yoshipls/models/Tracker.dart';

AppState appReducer(AppState state, action) {
  return new AppState(trackers: trackersReducer(state.trackers, action));
}
