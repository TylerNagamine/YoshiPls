import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:meta/meta.dart';

import 'package:yoshipls/store/app_state.dart';
import 'package:yoshipls/models/tracker.dart';
import 'package:yoshipls/store/trackers/actions.dart';
import 'package:yoshipls/tracker/tracker_widget.dart';

class TrackerWidgetContainer extends StatelessWidget {
  final String trackerId;

  TrackerWidgetContainer({ this.trackerId, Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store, trackerId),
      builder: (BuildContext context, _ViewModel viewModel) {
        return new TrackerWidget(tracker: viewModel.tracker, editTracker: viewModel.editTracker);
      },
    );
  }
}

class _ViewModel {
  final Tracker tracker;
  final EditTracker editTracker;

  _ViewModel({
    @required this.tracker,
    @required this.editTracker,
  });

  static _ViewModel fromStore(Store<AppState> store, String id) {
    final tracker = store.state.trackers.firstWhere((t) => t.id == id);

    return new _ViewModel(
      editTracker: (int success, int failure) {
        store.dispatch(new UpdateTrackerAction(id, success, failure));
      },
      tracker: tracker,
    );
  }
}
