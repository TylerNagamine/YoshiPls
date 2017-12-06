import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:yoshipls/store/app_state.dart';
import 'package:yoshipls/models/tracker.dart';
import 'package:yoshipls/store/trackers/actions.dart';
import 'package:yoshipls/tracker/tracker_widget.dart';

class TrackerWidgetContainer extends StatelessWidget {
  final Tracker tracker;

  TrackerWidgetContainer({ this.tracker, Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, EditTracker>(
      converter: (Store<AppState> store) {
        return (successes, failures) {
          store.dispatch(new UpdateTrackerAction(tracker.id, successes, failures));
        };
      },
      builder: (BuildContext context, EditTracker editTracker) {
        return new TrackerWidget(tracker: tracker, editTracker: editTracker);
      },
    );
  }
}
