import 'package:flutter/material.dart';
import 'demo/TextDemo.dart';
import 'demo/ImageDemo.dart';
import 'demo/ListViewDemo.dart';
import 'demo/GridViewDemo.dart';
import 'demo/ScrollTitleDemo.dart';
import 'demo/BottomTabBarDemo.dart';
import 'demo/BottomScrollTabBarDemo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 学习',
      home:Scaffold(
        appBar: AppBar(
          title: Text('Flutter 学习'),
        ),
        body:MyListView(items: ListData,),
        )

    );
  }
}

const ListData = [

  'flutter Text组件',
  'flutter Image组件',
  'flutter ListView组件',
  'flutter GridView组件',
  'flutter 滑动标题',
  'flutter tabbar效果',
  'flutter tabbar左右滑动效果',


];

class MyListView extends StatelessWidget{


   List<String> items;

   MyListView({this.items});

  @override
  Widget build(BuildContext context) {

    return ListView.builder(

        itemCount: items.length*2,//分割线也和item一样所以数量需要乘2
        itemBuilder: (context,index){


          //在每个item前面加分割线
          if(index.isOdd){

            return const Divider();
          }

          int i = index ~/2;
          return ListTile(


            title: Text('${items[i]}'),


            onTap: (){

              switch(i){

                case 0:
                  Navigator.push(context, new MaterialPageRoute(builder: (context)=>new TextDemo()));
                  break;
                case 1:
                  Navigator.push(context, new MaterialPageRoute(builder: (context)=>new ImageDemo()));
                  break;
                case 2:
                  Navigator.push(context, new MaterialPageRoute(builder: (context)=>new ListViewDemo()));
                  break;
                  case 3:
                  Navigator.push(context, new MaterialPageRoute(builder: (context)=>new GridViewDemo()));
                  break;
                  case 4:
                  Navigator.push(context, new MaterialPageRoute(builder: (context)=>new ScrollTitleDemo()));
                  break;
                  case 5:
                  Navigator.push(context, new MaterialPageRoute(builder: (context)=>new BottomTabBarDemo()));
                  break;
                  case 6:
                  Navigator.push(context, new MaterialPageRoute(builder: (context)=>new BottomScrollTabBarDemo()));
                  break;


              }

            },
          );

        }

    );

  }


}