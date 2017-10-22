import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'dart:async';

// TODO: REMOVE
import 'dart:math';

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

class EmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(child: new Text('Stuff'));
  }
}

class Counter extends StatelessWidget {
  Counter({ Key key, @required this.counter, @required this.onClick }) : super(key: key);

  final int counter;
  final ValueChanged<int> onClick;

  @override Widget build(BuildContext context) {
    return new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CounterCount(counter: this.counter),
            new IconButton(
              icon: new Icon(Icons.add),
              onPressed: () {
                this.onClick(this.counter + 1);
              }),
          ],
        ),
      );
  }
}

class CounterCount extends StatelessWidget {
  CounterCount({ Key key, this.counter }) : super(key: key);

  final int counter;

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Column(
          // Invoke "debug paint" (press "p" in the console where you ran
          // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
          // window in IntelliJ) to see the wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      );
  }
}

class Tracker {
  String name;
  int successes;
  int failures;

  Tracker(this.name, { this.successes = 0, this.failures = 0 });

  int getSuccessRate() {
    if (this.failures == 0) {
      return 0;
    }

    return ((this.successes / (this.successes + this.failures)) * 100).toInt();
  }
}

typedef void TrackerFunction(Tracker tracker);
class TrackerListItem extends StatelessWidget {
  final Tracker _tracker;
  final TrackerFunction _navigate;

  TrackerListItem(this._tracker, this._navigate);
  
  @override
  Widget build(BuildContext context) {
    return new MergeSemantics(
      child: new ListTile(
        title: new Text(_tracker.name),
        onTap: () { this._navigate(this._tracker); },
      )
    );
  }
}

typedef void EditTracker(int success, int failure);
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
              child: new Text('Success!'),
              onPressed: this._addSuccess,
            ),
            new FlatButton(
              child: new Text('Failure :('),
              onPressed: this._addFailure,
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Tracker> _trackers = new List<Tracker>();

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

  EditTracker _editTracker(Tracker tracker) {
    return (int successes, int failures) {
      setState(() {
        tracker.successes = successes;
        tracker.failures = failures;
      });
    };
  }

  void _onTrackerClick(BuildContext context, Tracker tracker) {
    var editFunc = _editTracker(tracker);

    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) {
        return new TrackerWidget(tracker: tracker, editTracker: editFunc);
      },
    ));
  }

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
