import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:yoshipls/store/app_state.dart';
import 'package:yoshipls/store/app_state_reducer.dart';
import 'package:yoshipls/store/trackers/actions.dart';
import 'package:yoshipls/store/middleware/repository_middleware.dart';
import 'package:yoshipls/tracker/tracker_list/tracker_list.container.dart';
import 'package:yoshipls/tracker/add_tracker_button/add_tracker_button.container.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  final store = new Store(
    appReducer,
    initialState: new AppState.loading(),
    middleware: createRepositoryMiddleware());

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new MaterialApp(
        title: 'YoshiPls Success Tracker',
        theme: new ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: new StoreBuilder<AppState>(
          onInit: (store) => store.dispatch(new LoadTrackersAction()),
          builder: (context, store) => new MyHomePage(title: 'YoshiPls Success Tracker'),
        ),
      ),
    );
  }
}

/// Main application widget
/// Handles all application state
class MyHomePage extends StatelessWidget {
  MyHomePage({ Key key, this.title }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new TrackerListContainer(),
        floatingActionButton: new AddTrackerButtonContainer(),
      );
  }
}
