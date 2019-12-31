import 'package:flutter/material.dart';


class ScrollTitleDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {


    return new DefaultTabController(length: titles.length,

        child:Scaffold(
          appBar: AppBar(
            title: Text('滚动标题'),
            bottom:TabBar(

              //设置标题超出是否可以滚动
                isScrollable: true,

                tabs: titles.map((title){

                  return Tab(
                    text: title,
                  );

                }).toList()
            ),
          ),

          body:TabBarView(
            children:titles.map((title){

             return Center(

               child: Text(title) ,

             );

            }).toList(),
          ),
        )


    );
  }


}

/*准备标题*/
const titles = [

  "推荐",
  "热门",
  "搞笑",
  "财经",
  "娱乐",
  "视频",
  "头条",
  "游戏",
  "购物",
  "八卦"

];
