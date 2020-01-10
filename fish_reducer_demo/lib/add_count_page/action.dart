import 'package:fish_redux/fish_redux.dart';

enum AddCountAction { addCount, reduce, onReduce, onAddCount }

class AddCountActionCreator {
  static Action addCount() {
    return const Action(AddCountAction.addCount);
  }

  static Action reduce() {
    return const Action(AddCountAction.reduce);
  }

  static Action onAddCount() {
    return const Action(AddCountAction.onAddCount);
  }

  static Action onReduce() {
    return const Action(AddCountAction.onReduce);
  }
}
