import 'package:flutter/material.dart';

import '../models/Tracker.dart';

/// Tracker list item, displayed in a ListView.
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
