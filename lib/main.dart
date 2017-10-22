import 'package:flutter/material.dart';
import 'dart:async';

import 'tracker/TrackerListItem.dart';
import 'tracker/TrackerWidget.dart';
import 'models/Tracker.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'YoshiPls Success Tracker'),
    );
  }
}

/// Main application widget
/// Handles all application state
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

/// Main application state
class _MyHomePageState extends State<MyHomePage> {
  /// List of trackers currently in memory.
  List<Tracker> _trackers = new List<Tracker>();

  /// Displays a dialog to prompt the user for a tracker name,
  /// then creates a tracker.
  Future<Null> _addTracker(BuildContext context) async {
    String nameValue;
    var name = await showDialog<String>(
      context: context,
      child: new SimpleDialog(
        title: new Text('Create a Tracker'),
        contentPadding: new EdgeInsets.all(10.0),
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
      setState(() {
        var newTracker = new Tracker(name, successes: 0, failures: 0);

        this._trackers.add(newTracker);
      });
    }
  }

  /// Function to edit a tracker in state.
  EditTracker _editTracker(Tracker tracker) {
    return (int successes, int failures) {
      setState(() {
        tracker.successes = successes;
        tracker.failures = failures;
      });
    };
  }

  /// Navigates to a tracker.
  void _onTrackerClick(BuildContext context, Tracker tracker) {
    var editFunc = _editTracker(tracker);

    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) {
        return new TrackerWidget(tracker: tracker, editTracker: editFunc);
      },
    ));
  }

  /// Creates a tracker tile to display in the ListView.
  Widget _buildListTile(BuildContext context, Tracker tracker) {
    return new TrackerListItem(tracker, (Tracker t) { this._onTrackerClick(context, t); });
  }

  @override
  Widget build(BuildContext context) {
    var items = this._trackers.map((tracker) => this._buildListTile(context, tracker));

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new ListView(
        children: items.toList(),
      ),
      floatingActionButton: new FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {this._addTracker(context); },
      ),
    );
  }
}
