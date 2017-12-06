import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import 'package:yoshipls/models/tracker.dart';
import 'package:yoshipls/tracker/tracker_list_item.dart';
import 'package:yoshipls/tracker/tracker_widget.container.dart';

class TrackerList extends StatelessWidget {
  final List<Tracker> trackers;
  final bool isLoading;

  TrackerList({
    Key key,
    @required this.trackers,
    @required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildListView();
  }

  ListView _buildListView() {
    return new ListView.builder(
      itemCount: trackers.length,
      itemBuilder: (BuildContext context, int index) {
        final tracker = trackers[index];

        return new TrackerListItem(tracker: tracker, navigate: () => _navigate(context, tracker));
      },
    );
  }

  void _navigate(BuildContext context, Tracker tracker) {
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (_) => new TrackerWidgetContainer(trackerId: tracker.id),
    ));
  }
}
