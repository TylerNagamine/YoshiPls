import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:yoshipls/store/app_state.dart';
import 'package:yoshipls/store/trackers/actions.dart';
import 'package:yoshipls/store/app_state_reducer.dart';
import 'package:yoshipls/tracker/tracker_list_item.dart';
import 'package:yoshipls/tracker/tracker_widget.container.dart';
import 'package:yoshipls/models/tracker.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  final store = new Store(appReducer, initialState: new AppState(trackers: []));

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new MaterialApp(
        title: 'YoshiPls Success Tracker',
        theme: new ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: new MyHomePage(title: 'YoshiPls Success Tracker')
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
    return new StoreConnector<AppState, Store<AppState>>(
      converter: (store) => store,
      builder: (context, store) => new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new ListView(
          children: store.state.trackers.map((tracker) => _buildListTile(context, tracker)).toList(),
        ),
        floatingActionButton: new FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () { _addTracker(context, store); },
        ),
      ),
    );
  }

  /// Displays a dialog to prompt the user for a tracker name,
  /// then creates a tracker.
  Future<Null> _addTracker(BuildContext context, Store<AppState> store) async {
    String nameValue;

    var name = await showDialog<String>(
      context: context,
      child: new SimpleDialog(
        title: const Text('Create a Tracker'),
        contentPadding: const EdgeInsets.all(10.0),
        children: <Widget>[
          new TextField(
            decoration: new InputDecoration(
              labelText: 'Create a name for your tracker',
            ),
            onChanged: (String value) { nameValue = value; },
          ),
          new RaisedButton(
            onPressed: () { Navigator.pop(context, nameValue); },
            child: const Text('Create'),
          ),
        ],
      )
    );

    // Null indicates the user canceled the dialog.
    if (name != null) {
        var newTracker = new Tracker(name, successes: 0, failures: 0);
        newTracker.id = new DateTime.now().millisecondsSinceEpoch.toString();

        store.dispatch(new AddTrackerAction(newTracker));
    }
  }

  /// Creates a tracker tile to display in the ListView.
  Widget _buildListTile(BuildContext context, Tracker tracker) {
    return new TrackerListItem(tracker, (Tracker t) { _onTrackerClick(context, t); });
  }

  // Navigates to a tracker.
  void _onTrackerClick(BuildContext context, Tracker tracker) {
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext c) => new StoreConnector<AppState, Store<AppState>>(
          converter: (store) => store,
          builder: (context, store) {
            var thisTracker = store.state.trackers.firstWhere((value) => value.id == tracker.id);

            return new TrackerWidgetContainer(tracker: thisTracker);
          }
        ),
    ));
  }
}
