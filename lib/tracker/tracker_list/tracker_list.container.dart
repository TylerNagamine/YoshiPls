import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:yoshipls/store/app_state.dart';
import 'package:yoshipls/models/tracker.dart';
import 'package:yoshipls/tracker/tracker_list/tracker_list.dart';

class TrackerListContainer extends StatelessWidget {
  TrackerListContainer({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel model) {
        return new TrackerList(trackers: model.trackers, isLoading: model.isLoading);
      }
    );
  }
}

class _ViewModel {
  final List<Tracker> trackers;
  final bool isLoading;

  _ViewModel({
    @required List<Tracker> trackers,
    @required bool isLoading,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      trackers: store.state.trackers,
      isLoading: store.state.isLoading,
    );
  }
}
