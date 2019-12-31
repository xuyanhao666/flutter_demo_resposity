import 'package:calender_date_picker/popCustomWidget.dart';
import 'package:calender_date_picker/pushAnnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(title: 'Flutter Demo Home Page'),
      // routes: <String, WidgetBuilder>{
      //   '/firstPage': (BuildContext context) => FirstPage(),
      // },
    );
  }
}

class FirstPage extends StatefulWidget {
  FirstPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String time = 'calender';

  DateTime _firstDate;
  DateTime _lastDate;
  DatePeriod _selectedPeriod;

  static const Color selectedPeriodStartColor = Colors.blueAccent;
  static const Color selectedPeriodLastColor = Colors.blueAccent;
  static const Color selectedPeriodMiddleColor = Colors.blueAccent;

  @override
  void initState() {
    super.initState();

    _firstDate = DateTime.now().subtract(Duration(days: 9999));
    _lastDate = DateTime.now().add(Duration(days: 9999));

    DateTime selectedPeriodStart = DateTime.now().subtract(Duration(days: 7));
    DateTime selectedPeriodEnd = DateTime.now();
    _selectedPeriod = DatePeriod(selectedPeriodStart, selectedPeriodEnd);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // defaults for styles
    // selectedPeriodLastColor = Theme.of(context).accentColor;
    // selectedPeriodMiddleColor = Colors.yellowAccent;
    // selectedPeriodStartColor = Theme.of(context).accentColor;
  }

  DatePickerRangeStyles styles = DatePickerRangeStyles(
    selectedPeriodLastDecoration: BoxDecoration(
        color: selectedPeriodLastColor,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0))),
    selectedPeriodStartDecoration: BoxDecoration(
      color: selectedPeriodStartColor,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
    ),
    selectedPeriodMiddleDecoration: BoxDecoration(
        color: selectedPeriodMiddleColor, shape: BoxShape.rectangle),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(time),
      ),
      body: Center(
        // color: Colors.blueAccent,
        child: Container(
          child: FloatingActionButton(
            onPressed: () {
              // Navigator.push(context, CustomRouteZoom(FirstPage(
              //     // clickCallback: _dateChanged,
              //     )));

              PopCalender(
                  context: context,
                  customWidget: RangePicker(
                    selectedPeriod: _selectedPeriod,
                    onChanged: _onSelectedDateChanged,
                    firstDate: _firstDate,
                    lastDate: _lastDate,
                    datePickerStyles: styles,
                  ),
                  buttons: [
                    DialogButton(
                        color: Colors.white,
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(color: Colors.blue, fontSize: 15),
                        )),
                    DialogButton(
                        color: Colors.white,
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(color: Colors.blue, fontSize: 15),
                        )),
                    DialogButton(
                        color: Colors.white,
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(color: Colors.blue, fontSize: 15),
                        ))
                  ]).show();
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  void _dateChanged(DatePeriod period) {
    time = 'start:' +
        period.start.toString() +
        '\n' +
        'end:' +
        period.end.toString();
    setState(() {});
    print(time);
  }

  void _onSelectedDateChanged(DatePeriod newPeriod) {
    setState(() {
      _selectedPeriod = newPeriod;
    });
    // Toast.show(
    //     'start:' +
    //         _selectedPeriod.start.toString() +
    //         '\n' +
    //         'end:' +
    //         _selectedPeriod.end.toString(),
    //     context,
    //     duration: Toast.LENGTH_LONG,
    //     gravity: Toast.CENTER);
  }
}
