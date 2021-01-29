import 'package:flutter/material.dart';
import 'package:flutter_coding/pageview_indicator/page_indicator_main.dart';
import 'package:flutter_coding/pageview_indicator/yj/yj_pageview_indicator_demo.dart';

void main() {
  runApp(MyApp());
}

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
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> _list = [
    {'title': 'PageView Indicator', 'widget': PageIndicatorDemo()},
    {'title': 'YJ PageView Indicator', 'widget': YJPageViewIndicatorDemo()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Coding'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${_list[index]['title']}'),
            onTap: () {
              return Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return _list[index]['widget'];
              }));
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: _list.length,
      ),
    );
  }
}
