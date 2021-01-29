import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coding/pageview_indicator/yj/yj_pageview_indicator.dart';

class YJPageViewIndicatorDemo extends StatefulWidget {
  @override
  _YJPageViewIndicatorStateDemo createState() =>
      _YJPageViewIndicatorStateDemo();
}

class _YJPageViewIndicatorStateDemo extends State<YJPageViewIndicatorDemo> {
  var imgList = [
    'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2877516247,37083492&fm=26&gp=0.jpg',
    'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1603523390,1101669963&fm=26&gp=0.jpg',
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F2020-04-23%2F5ea10703dd194.jpg&refer=http%3A%2F%2Fpic1.win4000.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg',
    'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2384063294,1698559024&fm=26&gp=0.jpg',
    'http://pic1.win4000.com/pic/4/df/2178b0aeb7.jpg'
  ];
//  var imgList = ['http://pic1.win4000.com/pic/4/df/2178b0aeb7.jpg'];

  PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YJ PageView Indicator'),
      ),
      body: Container(
          margin: EdgeInsets.only(top: 50),
          height: 230,
          child: _buildPageView()),
    );
  }

  _buildPageView() {
    return Center(
      child: Container(
        height: 230,
        color: Colors.red,
        child: Stack(
          children: [
            PageView.builder(
              onPageChanged: (int index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemCount: imgList.length,
              itemBuilder: (context, index) {
                return _buildPageViewItem(index);
              },
            ),
            IndicatorWidget(
              imgList.length,
              _currentPageIndex,
              isShow: true,
            ),
          ],
        ),
      ),
    );
  }

  ///item
  _buildPageViewItem(int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
            image: NetworkImage(imgList[index]), fit: BoxFit.cover),
      ),
    );
  }
}
