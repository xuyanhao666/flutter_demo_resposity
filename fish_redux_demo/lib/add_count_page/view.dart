import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'action.dart';
import 'state.dart';

Widget buildView(
    AddCountState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(title: Text('第一次redux尝试')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(state.count.toString()),
          FloatingActionButton(
            onPressed: () => dispatch(AddCountActionCreator.onAddCount()),
            tooltip: 'add',
            child: Icon(Icons.arrow_upward),
          ),
          FloatingActionButton(
            onPressed: () => dispatch(AddCountActionCreator.onReduce()),
            tooltip: 'reduce',
            child: Icon(Icons.arrow_downward),
          ),
        ],
      ),
    ),
  );
}
