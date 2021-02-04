import 'package:flutter/material.dart';
import 'file:///F:/flutterProject/flutter_dot/lib/qt/page_dot.dart';


///
/// desc:
///
class PageDripIndicatorDemo extends StatefulWidget {
  @override
  _PageDripIndicatorDemoState createState() => _PageDripIndicatorDemoState();
}

class _PageDripIndicatorDemoState extends State<PageDripIndicatorDemo> {
  PageController _controller;
  var imgList = [
    'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1641485239,2148402246&fm=26&gp=0.jpg',
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F2019-11-21%2F5dd6274859f1d.jpg&refer=http%3A%2F%2Fpic1.win4000.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1613979373&t=8821b6fbc0bb9f0681b65a564c84bc15',
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpicture.ik123.com%2Fuploads%2Fallimg%2F170830%2F12-1FS0142240.jpg&refer=http%3A%2F%2Fpicture.ik123.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1613979212&t=a8b5170e6f2601623af5428c486bc91e',
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fuploadfile.bizhizu.cn%2F2017%2F1009%2F2eb44a68ef5b7fccc127d96001010352.jpg.source.jpg&refer=http%3A%2F%2Fuploadfile.bizhizu.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1613979188&t=e48b9a1b29433645e63a26457b525dbb',
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F2019-10-31%2F5dba538e78e11.jpg&refer=http%3A%2F%2Fpic1.win4000.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1613979188&t=7885d2cf5bb9121a2eae77f76d8d69f7',
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: imgList.length,
            controller: _controller,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                      image: NetworkImage(imgList[index % imgList.length]),
                      fit: BoxFit.fill),
                ),
              );
            },
          ),
          Positioned(
            child: PageDot(
              controller: _controller,
              count: imgList.length,
              size: 20,
              activeColor: Colors.blue,
              inactiveColor: Colors.grey,
            ),
            left: 100,
            right: 100,
            bottom: 20,
          )
        ],
      ),
    );
  }
}
