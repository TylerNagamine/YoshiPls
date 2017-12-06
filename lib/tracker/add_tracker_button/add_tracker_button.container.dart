import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:yoshipls/store/app_state.dart';
import 'package:yoshipls/models/tracker.dart';
import 'package:yoshipls/store/trackers/actions.dart';
import 'package:yoshipls/tracker/add_tracker_button/add_tracker_button.dart';


class AddTrackerButtonContainer extends StatelessWidget {
  AddTrackerButtonContainer({ Key key }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, TrackerFunction>(
      converter: (Store<AppState> store) {
        return (Tracker tracker) {
          store.dispatch(new AddTrackerAction(tracker));
        };
      },
      builder: (BuildContext context, TrackerFunction addTracker) {
        return new AddTrackerButton(addTracker: addTracker); 
      },
    );
  }
}
