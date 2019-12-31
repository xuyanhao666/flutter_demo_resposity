import 'package:flutter/material.dart';
import './movie_detail.dart';

//配置路由
 final routes = {
    '/detail' : (BuildContext context,{arguments}) => MovieDetail(arguments:arguments),
  };

//固定命名路由写法
var onGenerateRoute = (RouteSettings setting){
        //统一处理
  final String name = setting.name;
  final Function pageContentBuilder = routes[name];
  if(pageContentBuilder != null){
    if(setting.arguments != null){
      final Route route = MaterialPageRoute(
        builder: (context) => pageContentBuilder(context, arguments: setting.arguments)
      );
      return route;
    }else{
      final Route route = MaterialPageRoute(
        builder: (context) => pageContentBuilder(context)
      );
      return route;
    }
  }
};

