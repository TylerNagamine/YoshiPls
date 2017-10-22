import 'package:flutter/material.dart';

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
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _setCounter(int newCount) {
    setState(() {
      _counter = newCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Counter(counter: this._counter, onClick: this._setCounter),
    );
  }
}
