import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/bezier_circle_header.dart'; //如果要使用炫酷的样式需要引入，不同的样式引入不同的文件，详见官方api
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart'; //如果要使用炫酷的样式需要引入，不同的样式引入不同的文件，详见官方api

Dio dio = Dio();

class FirstPage extends StatefulWidget {
  FirstPage({Key key, @required this.movieType}) : super(key: key);
  final String movieType;

  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>
    with AutomaticKeepAliveClientMixin {
  //默认当前第一页
  int page = 1;
  //索引请求index
  int offset = 0;
  //每页的条数
  int pageCount = 5;
  //电影列表数据
  var movieList = [];
  //每次请求时中间量数组
  var onceMoviesList = [];
  //总数据条数，用来实现分页效果的。
  int total = 0;

  @override
  bool get wantKeepAlive => true;

  //控件被创建的时候会执行initState方法
  @override
  void initState() {
    super.initState();

    _getMovieList();
  }

  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  bool _loadMore = true;
  //渲染当前这个FirstPage控件的UI结构
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh(
      key: _easyRefreshKey,
      refreshHeader: ClassicsHeader(
        key: _headerKey,
        refreshText: "下拉刷新",
        refreshReadyText: "释放刷新",
        refreshingText: '正在刷新' + "...",
        refreshedText: '已刷新',
        moreInfo: '',
        bgColor: Colors.transparent,
        textColor: Colors.black87,
        moreInfoColor: Colors.black54,
        showMore: true,
      ),
      refreshFooter: ClassicsFooter(
        key: _footerKey,
        // color: Theme.of(context).scaffoldBackgroundColor,
        loadText: "上拉加载更多",
        loadReadyText: "释放加载更多",
        loadingText: '正在加载' + "...",
        loadedText: '已刷新',
        noMoreText: '无更多数据',
        moreInfo: 'updateAt',
        bgColor: Colors.transparent,
        textColor: Colors.black87,
        moreInfoColor: Colors.black54,
        showMore: true,
      ),
      onRefresh: () async {
        print('已经下拉刷新');
        await new Future.delayed(const Duration(milliseconds: 100), () {
          offset = 0;
          movieList.clear();
          setState(() {
            _getMovieList();
            // _easyRefreshKey.currentState.waitState(() {
            //   setState(() {
            //     _loadMore = true;
            //   });
            // });
          });
        });
      },
      loadMore: null,
      // ? () async {
      //     print('已经上拉加载更多');
      //     await new Future.delayed(const Duration(milliseconds: 100), () {

      //       if (page < 4) {
      //         setState(() {
      //           page = page + 1;
      //            _getMovieList();
      //         });
      //       } else {
      //         _easyRefreshKey.currentState.waitState(() {
      //           setState(() {
      //             _loadMore = false;
      //           });
      //         });
      //       }
      //     });
      //   }
      // : null,
      child: ListView.builder(
          itemCount: movieList.length,
          semanticChildCount: onceMoviesList.length,
          itemBuilder: (BuildContext context, int index) {
            //mItem
            var mItem = movieList[index];

            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/detail', arguments: {
                  'id': mItem['id'],
                  'title': mItem['title'],
                });
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Colors.black12))),
                child: Row(
                  children: <Widget>[
                    Image.network(
                      mItem['images']['small'],
                      width: 130.0,
                      height: 180.0,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      height: 180.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text('电影名称：${mItem['title']}'),
                          Text('上映年份：${mItem['year']}年 index=$index'),
                          Text('电影类型：${mItem['genres'].join('，')}'),
                          Text('豆瓣评分：${mItem['rating']['average']}分'),
                          Row(
                            children: <Widget>[
                              Text('主要演员：'),
                              // for (var item in _casts) {
                              //   Image.network(item['small'],width: 40.0,height: 40.0,fit: BoxFit.cover,),
                              // }
                              ClipOval(
                                //这种方式也能实现圆形头像，但是建议用下面专业处理头像的控件。
                                child: Image.network(
                                  mItem['casts'][1]['avatars']['small'],
                                  width: 40.0,
                                  height: 40.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    mItem['casts'][0]['avatars']['small']),
                              ),
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    mItem['casts'][1]['avatars']['small']),
                              ),
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    mItem['casts'][2]['avatars']['small']),
                              ),

                              // Image.network(mItem['casts'][1]['avatars']['small'],width: 40.0,height: 40.0,fit: BoxFit.cover,),
                              // Image.network(mItem['casts'][2]['avatars']['small'],width: 40.0,height: 40.0,fit: BoxFit.cover,),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  _getMovieList() async {
    //http://www.liulongbin.top:3005/api/v2/movie/电影类型?start=偏移量&count=每页显示多少条数据
    //仿JS中的模板字符串
    //偏移量计算公式（page - 1）* pageCount
    // int offset = (page - 1) * pageCount;

    //引用变量时，当使用属性的时候（即用了点.）就要用大括号${}包括起来，直接引用对象的用$即可。
    var response = await dio.get(
        'http://www.liulongbin.top:3005/api/v2/movie/${widget.movieType}?start=$offset&count=$pageCount');

    //服务器返回的数据
    var result = response.data;
    print(result);
    //为私有数据赋值时，要放在setState函数中，否则页面不会更新。
    setState(() {
      onceMoviesList.clear();
      onceMoviesList = result['subjects'];
      offset = offset + onceMoviesList.length;
      movieList.addAll(onceMoviesList);
      total = result['total'];
    });
  }
}
