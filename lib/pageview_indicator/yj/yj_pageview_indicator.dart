import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef SelectedCallBack = Function(int selIndex);

class IndicatorWidget extends StatelessWidget {
  final int count;

  ///总的数量
  final int currentIndex;

  ///当前index
  final Color selColor;

  ///选择颜色
  final Color defaultColor;

  ///默认选择
  final double size;

  ///大小
  final double bottom;

  ///位置
  final bool isShow; // 只有一个的时候是否现在

  const IndicatorWidget(this.count, this.currentIndex,
      {Key key,
      this.selColor = Colors.blue,
      this.defaultColor = Colors.grey,
      this.size = 10.0,
      this.bottom = 10,
      this.isShow = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      left: 0,
      right: 0,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(count, (i) {
            return (count == 1 && isShow == false)
                ? Container()
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentIndex == i ? selColor : defaultColor),
                  );
          }).toList(),
        ),
      ),
    );
  }
}
