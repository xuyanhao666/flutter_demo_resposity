import 'package:flutter/material.dart';


class BottomTabBarDemo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return TabBarDemo();
  }

}

class TabBarDemo extends State<BottomTabBarDemo>{



  List<BottomNavigationBarItem> items;
  var bodys;


  int _active=0;

  @override
  void initState() {

    super.initState();

    items=[

      BottomNavigationBarItem(title:Text('首页'),activeIcon: Icon(Icons.home), icon: Icon(Icons.home)),
      BottomNavigationBarItem(title:Text('我的'),activeIcon: Icon(Icons.portrait), icon: Icon(Icons.portrait)),

    ];

  }

  void initData(){

    bodys=IndexedStack(
      children:[Home(),My()] ,
      index: _active,
    );
    

  }

  @override
  Widget build(BuildContext context) {

    initData();
    BottomNavigationBar tabbar = BottomNavigationBar(

      items: items.map((item){
        return item;
      }).toList(),

      currentIndex: _active,
      type: BottomNavigationBarType.fixed,
      onTap: (index){

        setState(() {

          _active=index;
        });

      },


    );

    return  Scaffold(

        appBar: AppBar(

          title: Text('tabbar效果'),
        ),

        body:bodys,

        bottomNavigationBar: tabbar,

    );
  }



}


class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(

        body: Center(
          
          child: Text('首页'),

        ),

      );

  }

}

class My extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: Center(

          child: Text('我的'),
        ),

    );
  }

}