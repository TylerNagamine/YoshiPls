import 'package:flutter/material.dart';

import 'package:yoshipls/models/Tracker.dart';

/// Tracker list item, displayed in a ListView.
class TrackerListItem extends StatelessWidget {
  final Tracker tracker;
  final TrackerFunction navigate;

  TrackerListItem(this.tracker, this.navigate);
  
  @override
  Widget build(BuildContext context) {
    return new MergeSemantics(
      child: new ListTile(
        title: new Text(tracker.name),
        onTap: () { navigate(tracker); },
      )
    );
  }
}
