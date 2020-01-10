import 'package:fish_reducer_demo/add_count_page/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

main(List<String> args) {
  return runApp(createApp());
}

//根 Widget
//1.routes 路由
//2.页面连接store
//3.AOP增强
Widget createApp() {
  //PageRoutes 是 fish_redux 提供的基本路由API，每个 page 都有独立的 store
  final AbstractRoutes routes = PageRoutes(
      //注册应用的页面 'todo_list' 、 'todo_edit'
      pages: <String, Page<Object, dynamic>>{
        'homePage': AddCountPage(),
      },
      visitor: (String path, Page<Object, dynamic> page) {
        //AOP，面向切面编程，主要作用是在不影响原有逻辑的基础上，增添一些常用的功能（比如打印日志、安全检查）。与业务逻辑解耦合，无侵入性。
        /// 页面可以有一些私有的 AOP 的增强， 但往往会有一些 AOP 是整个应用下，所有页面都会有的。
        /// 这些公共的通用 AOP ，通过遍历路由页面的形式统一加入。
        page.enhancer.append(
            //view AOP
            viewMiddleware: <ViewMiddleware<dynamic>>[
              safetyView<dynamic>(),
            ],

            //Adapter AOP
            adapterMiddleware: <AdapterMiddleware<dynamic>>[
              safetyAdapter<dynamic>(),
            ],

            //effect AOP
            effectMiddleware: [
              _pageAnalyticsMiddleware<dynamic>(),
            ],

            //Store AOP
            middleware: <Middleware<dynamic>>[
              //这块主要用到middleware的打印功能，监听Action在页面间的调整过程
              logMiddleware<dynamic>(tag: page.runtimeType.toString()),
            ]);
      });

  return MaterialApp(
    title: 'fish_redux',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    //主页显示的page，根据'homePage'在routes中找到相应的page
    home: routes.buildPage('homePage', null),
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute<Object>(builder: (BuildContext context) {
        return routes.buildPage(settings.name, settings.arguments);
      });
    },
  );
}

/// 简单的 Effect AOP
/// 只针对页面的生命周期进行打印
EffectMiddleware<T> _pageAnalyticsMiddleware<T>({String tag = 'redux'}) {
  return (AbstractLogic<dynamic> logic, Store<T> store) {
    return (Effect<dynamic> effect) {
      return (Action action, Context<dynamic> ctx) {
        if (logic is Page<dynamic, dynamic> && action.type is Lifecycle) {
          println('${logic.runtimeType} ${action.type.toString()}');
        }
        return effect?.call(action, ctx);
      };
    };
  };
}
