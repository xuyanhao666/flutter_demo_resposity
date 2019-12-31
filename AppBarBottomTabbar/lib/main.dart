import 'package:flutter/material.dart';
import './SegementPage.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // 导入flutter的包
import 'translations.dart';
import 'application.dart';

void main() => runApp(MyApp());

/// 将App设置为Stateful，这让它可以响应刷新事件，调用应用的SetState()
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SpecificLocalizationDelegate _localeOverrideDelegate;

  @override
  void initState() {
    super.initState();

    /// 初始化一个新的Localization Delegate，有了它，当用户选择一种新的工作语言时，可以强制初始化一个新的Translations

    _localeOverrideDelegate = new SpecificLocalizationDelegate(null);

    /// 保存这个方法的指针，当用户改变语言时，我们可以调用applic.onLocaleChanged(new Locale('en',''));，通过SetState()我们可以强制App整个刷新
    applic.onLocaleChanged = onLocaleChange;
  }

  /// 改变语言时的应用刷新核心，每次选择一种新的语言时，都会创造一个新的SpecificLocalizationDelegate实例，强制Translations类刷新。
  onLocaleChange(Locale locale) {
    setState(() {
      _localeOverrideDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'My Application',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        _localeOverrideDelegate, // 注册一个新的delegate
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: applic.supportedLocales(), // 我们有了一个全局的APPLIC类来存放设置
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  String _title = 'dorayo';
  List<Tab> _mytabs = [];
  @override
  void initState() {
    super.initState();
    _mytabs = <Tab>[
      new Tab(text: '语文'),
      new Tab(text: '数学'),
      new Tab(text: '英语'),
      new Tab(text: '化学'),
      new Tab(text: '物理'),
      new Tab(text: '政治'),
      new Tab(text: '经济'),
      new Tab(text: '体育'),
    ];
    // applic.onLocaleChanged(new Locale('ch',''));
    _title = 'dorayo';
    // if (Translations.of(context).currentLanguage == 'ch') {
    //   _title = '哆啦A梦';
    // }
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: _mytabs.length,
      child: new Scaffold(
        appBar: new AppBar(
          // title: Text(Translations.of(context).text('main_title')),
          title: Text(_title),
          centerTitle: true,
          bottom: TabBar(
            tabs: _mytabs,
            isScrollable: true,
            labelColor: Colors.black,
          ),
        ),
        body: TabBarView(
          children: _mytabs.map((Tab tab) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      Translations.of(context).currentLanguage == 'ch'
                          ? applic.onLocaleChanged(new Locale('en', ''))
                          : applic.onLocaleChanged(new Locale('zh', 'CH'));

                      if (Translations.of(context).currentLanguage == 'ch') {
                        _title = '哆啦A梦';
                      } else {
                        _title = 'dorayo';
                      }
                      print(Translations.of(context).currentLanguage);
                    });
                  },
                  child: Text('点击切换语言'),
                ),
                Text(tab.text),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext ctx) {
                      return SegmentPage();
                    }));
                  },
                  child: Text(Translations.of(context).text('main_title')),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
