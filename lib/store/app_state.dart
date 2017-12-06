import 'package:meta/meta.dart';

import 'package:yoshipls/models/tracker.dart';

@immutable
class AppState {
  final List<Tracker> trackers;

  AppState({ this.trackers = const [] });

  AppState copyWith({ List<Tracker> trackers }) {
    return new AppState(trackers: trackers ?? this.trackers);
  }

  @override
  int get hashCode =>
    trackers.hashCode;

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is AppState &&
      runtimeType == other.runtimeType &&
      trackers == other.trackers;

  @override
  String toString() {
    return 'AppState{trackers: $trackers}';
  }
}
