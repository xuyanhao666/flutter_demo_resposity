import 'package:fish_redux/fish_redux.dart';

class AddCountState implements Cloneable<AddCountState> {
  int count = 0;

  @override
  AddCountState clone() {
    return AddCountState()..count = count;
  }
}

AddCountState initState(Map<String, dynamic> args) {
  return AddCountState();
}
