import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './constant.dart' show AppColors; 
import './firstPage.dart';
import './routes.dart';

void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHome(title: '这是我传过来的title'),
      onGenerateRoute: onGenerateRoute
    );
  }
}

class MyHome extends StatefulWidget {
  MyHome({Key key,this.title}) : super(key: key);
  final String title;

  _MyHomeState createState() => _MyHomeState();
}



class _MyHomeState extends State<MyHome> {

  int _selectIndex = 0;
  List<Widget> _pages;
  PageController _pageController;

  @override
  void initState() {
    super.initState();

    // _pages = [
    //   FirstPage(),
    //   SecondPage(),
    //   ThirdPage()
    // ];
    _pages = [
      FirstPage(movieType: 'in_theaters',),
      FirstPage(movieType: 'in_theaters',),
      FirstPage(movieType: 'top250',),
    ];
    _pageController = PageController(initialPage: _selectIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            //右侧行为按钮
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
            title: Text('电影列表'),
            //居中显示
            centerTitle: true),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.all(0),
            children: <Widget>[
              UserAccountsDrawerHeader(
                  accountEmail: Text('123@qq.com'),
                  accountName: Text('Bob'),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://randomuser.me/api/portraits/women/85.jpg'),
                  ),
                  //美化控件用到的
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'http://www.liulongbin.top:3005/images/bg1.jpg'),
                    ),
                  )),
              ListTile(
                title: Text('用户反馈'),
                trailing: Icon(Icons.feedback),
              ),
              ListTile(
                title: Text('系统设置'),
                trailing: Icon(Icons.settings),
              ),
              ListTile(
                title: Text('我要发布'),
                trailing: Icon(Icons.send),
              ),
              //分割线
              Divider(),
              ListTile(
                title: Text('注销'),
                trailing: Icon(Icons.exit_to_app),
              ),
            ],
          ),
        ),
        body: PageView.builder(
          itemBuilder: (BuildContext context, int index){
            return _pages[index];
          },
          onPageChanged: (int index){
            //这里记得交互事件的值一般写在此方法里
            setState(() {
              _selectIndex = index;
            });
          },
          controller: _pageController,
          itemCount: 3,
        ),

        bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          _bottomNavigationBarItem('正在热映', Icons.movie_filter),
          _bottomNavigationBarItem('即将上映', Icons.move_to_inbox),
          _bottomNavigationBarItem('Top250', Icons.movie),
        ],
        iconSize: 24,
        currentIndex: _selectIndex,
        onTap: (index) {
          setState(() {
            _selectIndex = index;
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );
          });
        },
        fixedColor: AppColors.tabbarSelectedColor,
        type: BottomNavigationBarType.fixed,
        ),
      );
  }
}

BottomNavigationBarItem _bottomNavigationBarItem(String text,IconData imageData){
  return BottomNavigationBarItem(
    title: Text(text),
    icon: Icon(
      imageData,
      color: Color(AppColors.tabbarColor),
    ),
    activeIcon: Icon(
      imageData,
      color: AppColors.tabbarSelectedColor
    ),
  );
}