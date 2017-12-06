import 'package:redux/redux.dart';
import 'package:yoshipls/store/loading/actions.dart';

final loadingReducer = combineTypedReducers<bool>([
  new ReducerBinding<bool, TrackersLoadedAction>(_setLoaded),
  new ReducerBinding<bool, TrackersNotLoadedAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}
