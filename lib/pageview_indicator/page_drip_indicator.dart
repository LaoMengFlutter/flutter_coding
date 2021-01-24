import 'dart:math';

import 'package:flutter/material.dart';

///
/// desc:
///

class PageDripIndicator extends StatefulWidget {
  final PageController controller;
  final int count;
  final int initPage;
  final double size;
  final Color activeColor;
  final Color inactiveColor;

  const PageDripIndicator(
      {Key key,
      this.controller,
      this.count,
      this.size,
      this.initPage = 0,
      this.activeColor,
      this.inactiveColor})
      : super(key: key);

  @override
  _PageDripIndicatorState createState() => _PageDripIndicatorState();
}

class _PageDripIndicatorState extends State<PageDripIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> leftXAnim, centerXAnim, rightXAnim;
  int _currentPage;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    _currentPage = widget.initPage;

    widget.controller.addListener(() {
      var _nowPage = widget.controller.page.round();
      if (_currentPage != _nowPage) {
        _updateAnim(_currentPage, _nowPage);
        _currentPage = _nowPage;
        _controller.reset();
        _controller.forward();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _updateAnim(_currentPage, _currentPage);
      });
    });
  }

  void _updateAnim(int fromPage, int toPage) {
    double _width = (context.findRenderObject() as RenderBox).size.width;
    double _radius = widget.size / 2;
    double _centerDistance =
        _computeCenterDistance(_width, _radius, widget.count);

    double _fromRightX = 2 * _radius + fromPage * _centerDistance;
    double _toRightX = 2 * _radius + toPage * _centerDistance;

    if (fromPage < toPage) {
      //向右移动
      rightXAnim = TweenSequence([
        TweenSequenceItem(
            tween: Tween(begin: _fromRightX, end: _toRightX), weight: 20),
        TweenSequenceItem(
            tween: Tween(begin: _toRightX, end: _toRightX), weight: 80),
      ]).animate(_controller);
    } else {
      //向左移动
      rightXAnim = TweenSequence([
        TweenSequenceItem(
            tween: Tween(begin: _fromRightX, end: _fromRightX), weight: 50),
        TweenSequenceItem(
            tween: Tween(begin: _fromRightX, end: _toRightX)
                .chain(CurveTween(curve: Curves.elasticOut)),
            weight: 50),
      ]).animate(_controller);
    }

    double _fromLeftX = fromPage * _centerDistance;
    double _toLeftX = toPage * _centerDistance;
    if (fromPage < toPage) {
      //向右移动
      leftXAnim = TweenSequence([
        TweenSequenceItem(
            tween: Tween(begin: _fromLeftX, end: _fromLeftX), weight: 50),
        TweenSequenceItem(
            tween: Tween(begin: _fromLeftX, end: _toLeftX)
                .chain(CurveTween(curve: Curves.elasticOut)),
            weight: 50),
      ]).animate(_controller);
    } else {
      //向左移动
      leftXAnim = TweenSequence([
        TweenSequenceItem(
            tween: Tween(begin: _fromLeftX, end: _toLeftX), weight: 20),
        TweenSequenceItem(
            tween: Tween(begin: _toLeftX, end: _toLeftX), weight: 80),
      ]).animate(_controller);
    }

    double _fromCenterX = _radius + fromPage * _centerDistance;
    double _toCenterX = _radius + toPage * _centerDistance;
    centerXAnim = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: _fromCenterX, end: _fromCenterX), weight: 20),
      TweenSequenceItem(
          tween: Tween(begin: _fromCenterX, end: _toCenterX), weight: 30),
      TweenSequenceItem(
          tween: Tween(begin: _toCenterX, end: _toCenterX), weight: 50),
    ]).animate(_controller);
  }

  ///
  /// 计算圆心之间的距离
  ///
  double _computeCenterDistance(double width, double radius, int count) {
    if (count == 1) {
      return 0.0;
    }
    return (width - 2 * radius) / (count - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(
                widget.count,
                (index) => Container(
                      width: widget.size,
                      height: widget.size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.inactiveColor,
                      ),
                    ))
          ],
        ),
        if (leftXAnim != null)
          Positioned.fill(
              child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Container(
                      height: widget.size,
                      child: CustomPaint(
                        painter: _DripPaint(
                            leftX: leftXAnim == null ? 0.0 : leftXAnim.value,
                            centerX: centerXAnim == null
                                ? (widget.size / 2)
                                : centerXAnim.value,
                            rightX: rightXAnim == null
                                ? (2 * widget.size / 2)
                                : rightXAnim.value,
                            color: widget.activeColor),
                      ),
                    );
                  }))
      ],
    );
  }
}

class _DripPaint extends CustomPainter {
  final double leftX, centerX, rightX, m;
  final Color color;
  Paint _paint = Paint();

  _DripPaint(
      {this.leftX,
      this.centerX,
      this.rightX,
      this.color = Colors.white,
      this.m = 0.55}) {
    _paint.color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //半径
    var _radius = size.height / 2;
    //控制点M值
    var mDistance = _radius * m;
    //圆心x坐标
    var _centerY = _radius;

    var p1X = centerX;
    var p1Y = 0.0;
    var p1RightX = p1X + mDistance;
    var p1RightY = p1Y;
    var p1LeftX = p1X - mDistance;
    var p1LeftY = p1Y;

    var p2X = rightX;
    var p2Y = _centerY;
    var p2TopX = p2X;
    var p2TopY = p2Y - mDistance;
    var p2BottomX = p2X;
    var p2BottomY = p2Y + mDistance;

    var p3X = centerX;
    var p3Y = size.height;
    var p3RightX = p3X + mDistance;
    var p3RightY = p3Y;
    var p3LeftX = p3X - mDistance;
    var p3LeftY = p3Y;

    var p4X = leftX;
    var p4Y = _centerY;
    var p4TopX = p4X;
    var p4TopY = p4Y - mDistance;
    var p4BottomX = p4X;
    var p4BottomY = p4Y + mDistance;

    Path _path = Path();
    _path.moveTo(p1X, p1Y);
    _path.cubicTo(p1RightX, p1RightY, p2TopX, p2TopY, p2X, p2Y);
    _path.cubicTo(p2BottomX, p2BottomY, p3RightX, p3RightY, p3X, p3Y);
    _path.cubicTo(p3LeftX, p3LeftY, p4BottomX, p4BottomY, p4X, p4Y);
    _path.cubicTo(p4TopX, p4TopY, p1LeftX, p1LeftY, p1X, p1Y);
    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
