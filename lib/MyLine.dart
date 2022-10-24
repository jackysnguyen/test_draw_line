import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:vector_math/vector_math.dart' hide Colors;
import 'dart:developer' as developer;

class MyLine extends CustomPainter {
  //Length of triangle's side a
  final Offset a;
  final Offset b;

  //Triangle's side width
  final double sideWidth;

  //Triangle's side color
  final Color sideColor;

  MyLine(
      {required this.a,
      required this.b,
      required this.sideWidth,
      required this.sideColor});

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    //Move to scaff
    path.moveTo(a.dx, a.dy);

    //Draw horizonal line from the center to the right, given user's length (a)
    path.lineTo(b.dx, b.dy);

    //Draw inner triangle based on the given coordinates (Inner triangle)
    Paint innerTriangle = Paint()..style = PaintingStyle.fill;

    canvas.drawPath(path, innerTriangle);

    //Draw outer triangle based on the given coordinates (Triangle's sides)
    Paint outerTriangle = Paint()
      ..color = sideColor
      ..strokeWidth = sideWidth
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, outerTriangle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class MyCircle extends CustomPainter {
  //Length of triangle's side a
  final Offset center;
  MyCircle({required this.center});

  @override
  void paint(Canvas canvas, Size size) {
    Paint outerTriangle = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 8, outerTriangle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class MyAngle extends CustomPainter {
  final Offset a;
  final Offset b;
  final Offset c;
  MyAngle({required this.a, required this.b, required this.c});

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(a.dx, a.dy);

    //Draw horizonal line from the center to the right, given user's length (a)
    path.lineTo(b.dx, b.dy);
    path.lineTo(c.dx, c.dy);

    Paint innerTriangle = Paint()..style = PaintingStyle.stroke;

    canvas.drawPath(path, innerTriangle);

    //Draw outer triangle based on the given coordinates (Triangle's sides)
    Paint outerTriangle = Paint()..style = PaintingStyle.stroke;

    canvas.drawPath(path, outerTriangle);
    drawAngleSymbol(a, b, c, canvas);
  }

  void drawAngleSymbol(Offset pt1, Offset pt2, Offset pt3, Canvas canvas) {
    print(pt3);
    print(pt2);
    print(pt1);
    var dx1 = pt1.dx - pt2.dx;
    var dy1 = pt1.dy - pt2.dy;
    var dx2 = pt3.dx - pt2.dx;
    var dy2 = pt3.dy - pt2.dy;
    var startAngle = atan2(dy1, dx1);
    var endAngle = atan2(dy2, dx2);
    print('dy1: ${dy1}');
    print('dx1: ${dx1}');
    print('dy2: ${dy2}');
    print('dx2: ${dx2}');
    var a = ((endAngle - startAngle) * 180 / pi + 360) % 360;
    Paint anglePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    // draw angleSymbol
    var rect = Rect.fromCircle(center: pt2, radius: 30);
    print('startAngle: ${startAngle}, degrees: ${degrees(startAngle)}');
    print('endAngle: ${endAngle}, degrees: ${degrees(endAngle)}');
    print('Góc : ${a}');

    var degreesStart = degrees(startAngle);
    var degreesEnd = degrees(endAngle);

    if (degreesEnd < 0) {
      degreesEnd = 360 + degreesEnd;
    }

    if (degreesStart < 0) {
      degreesStart = 360 + degreesStart;
    }
    print('startDegreesAft degrees: ${degreesStart}');
    print('endDegreesAft degrees: ${degreesEnd}');
    if (a > 180) {
      canvas.drawArc(rect, radians(degreesEnd),
          radians(degreesStart) - radians(degreesEnd), true, anglePaint);
    } else {
      canvas.drawArc(rect, startAngle, endAngle - startAngle, true, anglePaint);
    }

    //var textPainter = TextPainter(
    //  text: TextSpan(text: a.toString()), textDirection: TextDirection.ltr);
    // textPainter.paint(canvas, pt3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
