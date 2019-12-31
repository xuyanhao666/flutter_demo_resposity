import 'package:flutter/material.dart';

class ThirdPage extends StatefulWidget {
  ThirdPage({Key key}) : super(key: key);

  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('first'),
      color: Colors.yellowAccent,
      alignment: Alignment.center,
    );
  }
}
