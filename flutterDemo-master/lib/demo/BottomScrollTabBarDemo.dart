import 'package:flutter/material.dart';


class BottomScrollTabBarDemo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return TabBarDemo();
  }

}

class TabBarDemo extends State<BottomScrollTabBarDemo>{


  List<BottomNavigationBarItem> items;

  PageController pageController;


  int _active=0;

  @override
  void initState() {

    super.initState();
    pageController = PageController(initialPage: _active);
    items=[

      BottomNavigationBarItem(title:Text('首页'),activeIcon: Icon(Icons.home), icon: Icon(Icons.home)),
      BottomNavigationBarItem(title:Text('我的'),activeIcon: Icon(Icons.portrait), icon: Icon(Icons.portrait)),

    ];

  }


  @override
  Widget build(BuildContext context) {


    BottomNavigationBar tabbar = BottomNavigationBar(

      items: items.map((item){
        return item;
      }).toList(),

      //设置菜单选中颜色
      fixedColor: Colors.green,
      currentIndex: _active,
      type: BottomNavigationBarType.fixed,
      onTap: (index){

        setState(() {


          pageController.animateToPage(index, duration:const Duration(milliseconds: 300), curve: Curves.ease);


        });

      },


    );

    return  Scaffold(

        appBar: AppBar(
          
          title: Text('tabbar左右效果'),
        ),

        body:PageView(
          children: <Widget>[Home(),My()],
          onPageChanged: onChange,
          controller: pageController,
        ),


        bottomNavigationBar: tabbar,

    );
  }


  void onChange(int value) {


    setState(() {

      _active=value;

    });

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