import 'package:flutter/material.dart';

// TODO:Remove
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
}

class TrackerListItem extends StatelessWidget {
  final Tracker _tracker;
  final void _navigate;

  TrackerListItem(this._tracker, this._navigate);
  @override
  Widget build(BuildContext context) {
    return new MergeSemantics(
      child: new ListTile(
        title: new Text(_tracker.name),
        onTap: () { },
      )
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

  void _addTracker() {
    setState(() {
      var rng = new Random();
      var next = rng.nextInt(1000);

      var newTracker = new Tracker('Tracker!! $next', successes: 0, failures: 0);

      this._trackers.add(newTracker);
    });
  }

  Widget _buildListTile(BuildContext context, Tracker tracker) {
    return new TrackerListItem(tracker);
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
        onPressed: this._addTracker,
      ),
    );
  }
}
