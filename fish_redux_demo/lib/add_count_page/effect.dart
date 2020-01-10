import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<AddCountState> buildEffect() {
  return combineEffects(<Object, Effect<AddCountState>>{
    AddCountAction.onAddCount: _onAddCount,
    AddCountAction.onReduce: _onReduce,
  });
}

void _onAddCount(Action action, Context<AddCountState> ctx) {
  print("_onAdd");
  ctx.dispatch(AddCountActionCreator.addCount());
}

void _onReduce(Action action, Context<AddCountState> ctx) {
  print("_reduce");
  ctx.dispatch(AddCountActionCreator.reduce());
}
