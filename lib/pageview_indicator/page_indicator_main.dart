import 'package:flutter/material.dart';
import 'package:flutter_coding/pageview_indicator/yj/yj_pageview_indicator_demo.dart';

import 'page_drip_indicator_demo.dart';

///
/// des:
///
class PageIndicatorDemo extends StatelessWidget {
  List<Widget> _list = [PageDripIndicatorDemo()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PageView Indicator'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return _list[index];
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: _list.length,
      ),
    );
  }
}
