import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import 'package:yoshipls/models/tracker.dart';

/// Tracker list item, displayed in a ListView.
class TrackerListItem extends StatelessWidget {
  final Tracker tracker;
  final VoidCallback navigate;

  TrackerListItem({ @required this.tracker, @required this.navigate });
  
  @override
  Widget build(BuildContext context) {
    return new MergeSemantics(
      child: new ListTile(
        title: new Text(tracker.name),
        onTap: navigate,
      )
    );
  }
}
