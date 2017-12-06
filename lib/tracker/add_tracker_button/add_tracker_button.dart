import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'dart:async';

import 'package:yoshipls/models/tracker.dart';

class AddTrackerButton extends StatelessWidget {
  final TrackerFunction addTracker;

  AddTrackerButton({
    Key key,
    @required this.addTracker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () { _addTracker(context); },
    );
  }

  /// Displays a dialog to prompt the user for a tracker name,
  /// then creates a tracker.
  Future<Null> _addTracker(BuildContext context) async {
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

        addTracker(newTracker);
    }
  }
}
