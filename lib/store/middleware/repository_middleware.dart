import 'package:redux/redux.dart';

import 'package:yoshipls/models/tracker.dart';
import 'package:yoshipls/store/trackers/actions.dart';
import 'package:yoshipls/store/app_state.dart';

import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class YoshiPlsRepository {
  final String tag = 'yoshipls_app_';

  const YoshiPlsRepository();

  Future<List<Tracker>> loadTrackers() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();
    final jsonDecoder = new JsonDecoder();
    final json = jsonDecoder.convert(string);

    final trackers = (json['trackers'] as List<Map<String, dynamic>>)
      .map((tracker) => Tracker.fromJson(tracker))
      .toList();

      return trackers;
  }

  Future<File> saveTrackers(List<Tracker> trackers) async {
    final file = await _getLocalFile();

    var encoder = new JsonEncoder();

    var json = encoder.convert({
      'trackers': trackers.map((tracker) => tracker.toJson()).toList(),
    });

    return file.writeAsString(json);
  }

  Future<File> _getLocalFile() async {
    final dir = await _getDirectory();

    final file = new File('${dir.path}/YoshiPlsStorage__$tag.json');

    return file;
  }

  Future<Directory> _getDirectory() async {
    final directory = await getApplicationDocumentsDirectory();

    return directory;
  }
}

List<Middleware<AppState>> createRepositoryMiddleware([
  YoshiPlsRepository repository = const YoshiPlsRepository(),
]) {
  final saveTrackers = _createSaveTrackers(repository);
  final loadTrackers = _createLoadTrackers(repository);

  return combineTypedMiddleware([
    new MiddlewareBinding<AppState, LoadTrackersAction>(loadTrackers),
    new MiddlewareBinding<AppState, AddTrackerAction>(saveTrackers),
    new MiddlewareBinding<AppState, UpdateTrackerAction>(saveTrackers),
  ]);
}

Middleware<AppState> _createSaveTrackers(YoshiPlsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    final trackers = store.state.trackers;

    repository.saveTrackers(trackers);
  };
}

Middleware<AppState> _createLoadTrackers(YoshiPlsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    repository.loadTrackers().then((trackers) {
      store.dispatch(new TrackersLoadedAction(trackers: trackers));
    });

    next(action);
  };
}
