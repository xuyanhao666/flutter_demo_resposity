import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AddCountPage extends Page<AddCountState, Map<String, dynamic>> {
  AddCountPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<AddCountState>(
              adapter: null, slots: <String, Dependent<AddCountState>>{}),
          middleware: <Middleware<AddCountState>>[],
        );
}
