import 'package:flutter/material.dart';

/*
 静态listview
 */
class ListViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ListView 基本使用'),
        ),
        body: Column(
          children: <Widget>[
            Text('静态listview'),
            Container(
              height: 160,
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text('item1'),
                  ),
                  ListTile(
                    title: Text('item2'),
                  ),
                  ListTile(
                    title: Text('item2'),
                  ),
                ],
              ),
            ),
            Divider(),
            Text('动态listview'),
            Container(
              height: 200,
              child: ListViewDemo2(),
            ),
            Divider(),
            Text('横向listview'),
            Container(
              height: 200,
              child: ListViewDemo3(),
            ),
          ],
        ));
  }
}

/*
动态lietview数据源
 */
List<String> data = List<String>.generate(20, (index) => '动态item $index');

/*
动态listview
 */
class ListViewDemo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${data[index]}'),
          );
        });
  }
}

/*
 * 横向listview
 */
class ListViewDemo3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Container(
          width: 180,
          color: Colors.amberAccent,
        ),
        Container(
          width: 180,
          color: Colors.green,
        ),
        Container(
          width: 180,
          color: Colors.purple,
        ),
      ],
    );
  }
}
