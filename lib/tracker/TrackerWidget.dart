import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:yoshipls/models/Tracker.dart';

/// The main tracker widget.  Displays options for manipulating a tracker
/// (IE increment failures and successes), and shows state.
class TrackerWidget extends StatefulWidget {
  final Tracker tracker;
  final EditTracker editTracker;

  TrackerWidget({ Key key, @required this.tracker, @required this.editTracker }) : super(key: key);

  @override
  _TrackerWidgetState createState() => new _TrackerWidgetState(this.tracker);
}

class _TrackerWidgetState extends State<TrackerWidget> {
  Tracker _tracker;

  _TrackerWidgetState(this._tracker);

  void _addSuccess() {
    this.setState(() {
      _tracker.successes++;
      widget.editTracker(_tracker.successes, _tracker.failures);
    });
  }
  
  void _addFailure() {
    this.setState(() {
      _tracker.failures++;
      widget.editTracker(_tracker.successes, _tracker.failures);
    });
  }

  @override
  Widget build(BuildContext context) {
    var title = this._tracker.name;

    var success = this._tracker.successes;
    var fail = this._tracker.failures;

    var percentage = this._tracker.getSuccessRate();

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
              onPressed: this._addSuccess,
            ),
            new FlatButton(
              child: const Text('Failure :('),
              onPressed: this._addFailure,
            ),
          ],
        ),
      ),
    );
  }
}
