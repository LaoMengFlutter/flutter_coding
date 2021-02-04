import 'package:flutter/material.dart';

class PageDot extends StatefulWidget {
  final PageController controller;
  final int count;
  final int initPage;
  final double size;
  final Color activeColor;
  final Color inactiveColor;

  const PageDot(
      {Key key,
      this.controller,
      this.count,
      this.size,
      this.initPage = 0,
      this.activeColor,
      this.inactiveColor})
      : super(key: key);

  @override
  _PageDotState createState() => _PageDotState();
}

class _PageDotState extends State<PageDot> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _animation;
  int _currentPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    _animation =
        ColorTween(begin: widget.inactiveColor, end: widget.activeColor)
            .animate(_controller);

    _currentPage = widget.initPage;
    widget.controller.addListener(() {
      var _nowPage = widget.controller.page.round();

      if (_currentPage != _nowPage) {
        setState(() {
          _currentPage = _nowPage;
        });
        _controller.reset();
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(widget.count, (index) {
                return Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index
                          ? _animation.value
                          : widget.inactiveColor),
                );
              })
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // 释放资源
    _controller.dispose();
    super.dispose();
  }
}
