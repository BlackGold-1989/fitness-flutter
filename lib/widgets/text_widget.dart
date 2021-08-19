import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StrokeText extends Stack {
  StrokeText({
    Key key,
    @required String title,
    @required TextStyle textStyle,
    double strokeWidth = 2.0,
    Color strokeColor = Colors.white,
}) : super (
    children: [
      Text(
        title,
        style: textStyle.copyWith(fontSize: textStyle.fontSize, foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..color = strokeColor,),
      ),
      Text(
        title,
        style: textStyle,
      ),
    ],
  );
}