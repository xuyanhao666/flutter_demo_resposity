import 'package:flutter/material.dart';


class GridViewDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('GridView基本使用'),
      ),

      body:Column(

        children: <Widget>[
          Text('基本gridview1'),

          Container(
            height: 200,
            child: GridViewDemo1(),
          ),

          Divider(),
          Text('基本gridview2'),

          Container(
            height: 400,
            child: GridViewDemo2(),
          ),

        ],

      )

    );
  }


}



class GridViewDemo1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.count(

      crossAxisCount: 3,//设置显示的列数
      crossAxisSpacing: 10,//设置item间距
      children: <Widget>[
        Text('item1',textAlign: TextAlign.center,),
        Text('item2',textAlign: TextAlign.center,),
        Text('item3',textAlign: TextAlign.center,),
        Text('item4',textAlign: TextAlign.center,),
        Text('item5',textAlign: TextAlign.center,),
      ],
    );
  }


}


class GridViewDemo2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView(

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:3,//设置显示列数
          childAspectRatio: 0.75,//设置item宽高比例
          crossAxisSpacing: 2,//设置item的左右间距
          mainAxisSpacing: 2,//设置item上下间距

      ),
      children: <Widget>[
        Image.network('https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2539661066.webp',fit: BoxFit.cover),
        Image.network('https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2537158013.webp',fit: BoxFit.cover),
        Image.network('https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2535096871.webp',fit: BoxFit.cover),
        Image.network('https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2538352472.webp',fit: BoxFit.cover),
        Image.network('https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2536557304.webp',fit: BoxFit.cover),
        Image.network('https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2539424621.webp',fit: BoxFit.cover),

      ],
    );
  }


}