import 'package:meta/meta.dart';

import 'package:yoshipls/models/tracker.dart';

@immutable
class AppState {
  final List<Tracker> trackers;
  final bool isLoading;

  AppState({ this.trackers = const [], this.isLoading = false });

  AppState copyWith({ List<Tracker> trackers, bool isLoading }) {
    return new AppState(trackers: trackers ?? this.trackers, isLoading: isLoading ?? false);
  }

  @override
  int get hashCode =>
    trackers.hashCode ^
    isLoading.hashCode;

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is AppState &&
      runtimeType == other.runtimeType &&
      trackers == other.trackers &&
      isLoading == other.isLoading;

  @override
  String toString() {
    return 'AppState{trackers: $trackers}';
  }
}
