import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AddCountState> buildReducer() {
  return asReducer(
    <Object, Reducer<AddCountState>>{
      AddCountAction.addCount: _addCount,
      AddCountAction.reduce: _reduce,
    },
  );
}

AddCountState _addCount(AddCountState state, Action action) {
  final AddCountState newState = state.clone();
  newState.count = ++state.count;
  return newState;
}

AddCountState _reduce(AddCountState state, Action action) {
  final AddCountState newState = state.clone();
  newState.count = --state.count;
  return newState;
}
