import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SegmentPage extends StatefulWidget {
  SegmentPage({Key key}) : super(key: key);

  _SegmentPageState createState() => _SegmentPageState();
}

class _SegmentPageState extends State<SegmentPage> {
  final Map<int, Widget> children = const <int, Widget>{
    0: Text(
      '上游节点',
      style: TextStyle(color: Colors.white),
    ),
    1: Text(
      '下游节点',
      style: TextStyle(color: Colors.white),
    ),
    2: Text(
      '下游门店',
      style: TextStyle(color: Colors.white),
    ),
  };

  int sharedValue = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.black12,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.black,
        middle: const Text(
          'Segmented Control',
          style: TextStyle(color: Colors.white),
        ),
        // We're specifying a back label here because the previous page is a
        // Material page. CupertinoPageRoutes could auto-populate these back
        // labels.
        previousPageTitle: 'Cupertino',
        trailing: Icon(Icons.search),
      ),
      child: DefaultTextStyle(
        style: CupertinoTheme.of(context).textTheme.textStyle,
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(10.0),
            ),
            SizedBox(
              width: 800.0,
              // height: 100,
              child: CupertinoSegmentedControl<int>(
                unselectedColor: Colors.transparent,
                // selectedColor: Colors.blue,
                // borderColor: Colors.blue,
                children: children,
                onValueChanged: (int index) {
                  print(index);
                  setState(() {
                    sharedValue = index;
                  });
                },
                groupValue: sharedValue,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, top: 10.0),
              child: Text(
                '全部货主/全部门店/全部省份/全部城市/Factory',
                style: TextStyle(
                    color: Colors.white70, fontSize: 17, wordSpacing: 10.0),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, top: 10.0),
              child: Text(
                '高级搜索',
                style: TextStyle(
                    color: Colors.white70, fontSize: 17, wordSpacing: 17.0),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, top: 17.0),
              child: Text(
                '下游门店',
                style: TextStyle(
                    color: Colors.white, fontSize: 17, wordSpacing: 20.0),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: SizedBox(
                width: 600.0,
                child: Table(
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(100.0),
                    1: FixedColumnWidth(100.0),
                    2: FixedColumnWidth(100.0),
                    3: FixedColumnWidth(100.0),
                  },
                  border: TableBorder.all(
                      color: Colors.blue, style: BorderStyle.solid),
                  children: <TableRow>[
                    TableRow(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'A1',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  wordSpacing: 20.0),
                            ),
                            Text(
                              'A1',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  wordSpacing: 20.0),
                            ),
                          ],
                        ),
                        Text(
                          'B1',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              wordSpacing: 20.0),
                        ),
                        Text(
                          'C1',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              wordSpacing: 20.0),
                        ),
                        Text(
                          'D1',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              wordSpacing: 20.0),
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Text(
                          'A2',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              wordSpacing: 20.0),
                        ),
                        Text(
                          'B2',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              wordSpacing: 20.0),
                        ),
                        Text(
                          'C2',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              wordSpacing: 20.0),
                        ),
                        Text(
                          'D2',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              wordSpacing: 20.0),
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Text(
                          'A3',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              wordSpacing: 20.0),
                        ),
                        Text(
                          'B3',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              wordSpacing: 20.0),
                        ),
                        Text(
                          'C3',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              wordSpacing: 20.0),
                        ),
                        Text(
                          'D3',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              wordSpacing: 20.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
