import 'package:flutter/material.dart';

class MovieDetail extends StatefulWidget {
  MovieDetail({Key key, this.arguments}) : super(key: key);
  final Map arguments;

  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.arguments['title']}'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text(
                'movie ID: ${widget.arguments['id']}',
                style: TextStyle(color: Colors.blueAccent, fontSize: 17),
              ),
            ),
            LinearProgressIndicator(
              backgroundColor: Colors.blue,
              // value: 0.2,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
            ),
            new Offstage(
              offstage: false, //这里控制
              child: Container(
                color: Colors.blue,
                height: 100.0,
              ),
            ),
          ],
        ));
  }
}
