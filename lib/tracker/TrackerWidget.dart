import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:yoshipls/models/Tracker.dart';

/// The main tracker widget.  Displays options for manipulating a tracker
/// (IE increment failures and successes), and shows state.
class TrackerWidget extends StatelessWidget {
  final Tracker tracker;
  final EditTracker editTracker;

  TrackerWidget({ Key key, @required this.tracker, @required this.editTracker }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = tracker.name;

    var success = tracker.successes;
    var fail = tracker.failures;

    var percentage = tracker.getSuccessRate();

    return new Scaffold(
      appBar: new AppBar(title: new Text('$title')),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new Text('Success rate: $percentage%'),

            new Text('Successes: $success'),
            new Text('Failures: $fail'),

            new RaisedButton(
              child: const Text('Success!'),
              onPressed: _addSuccess,
            ),
            new FlatButton(
              child: const Text('Failure :('),
              onPressed: _addFailure,
            ),
          ],
        ),
      ),
    );
  }
  
  void _addSuccess() {
    var count = tracker.successes + 1;
    editTracker(count, tracker.failures);
  }
  
  void _addFailure() {
    var count = tracker.failures + 1;
    editTracker(tracker.successes, count);
  }
}
