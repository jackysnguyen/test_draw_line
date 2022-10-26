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

  MyAngle({required this.a, required this.b});

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    if (this.a.dx == 0 && this.b.dx == 0) {
      return;
    }

    var dyC = 0.00;

    if (this.a.dy > 200) {
      dyC = this.a.dy - 100;
    } else {
      dyC = this.a.dy + 100.0;
    }

    Offset c = Offset(this.a.dx, dyC);
    path.moveTo(a.dx, a.dy);

    //Draw horizonal line from the center to the right, given user's length (a)
    path.lineTo(b.dx, b.dy);

    Paint innerTriangle = Paint()..style = PaintingStyle.stroke;
    innerTriangle.color = Colors.red;

    canvas.drawPath(path, innerTriangle);

    //Draw outer triangle based on the given coordinates (Triangle's sides)
    Paint outerTriangle = Paint()..style = PaintingStyle.stroke;

    canvas.drawPath(path, outerTriangle);

    var path2 = Path();
    path2.moveTo(b.dx, b.dy);
    path2.lineTo(c.dx, c.dy);
    canvas.drawPath(path2, innerTriangle);

    drawAngleSymbol(a, b, c, canvas);
  }

  void drawAngleSymbol(Offset pt1, Offset pt2, Offset pt3, Canvas canvas) {
    print('a (pt1): ${pt1}');
    print('b (pt2): ${pt2}');
    print('c (pt3): ${pt3}');
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

    // if (a >= 180) {
    //   a = 360 - a;
    // }

    Paint anglePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    // draw angleSymbol
    var rect = Rect.fromCircle(center: pt2, radius: 30);
    print('startAngle radians: ${startAngle}, degrees: ${degrees(startAngle)}');
    print('endAngle radians: ${endAngle}, degrees: ${degrees(endAngle)}');
    print('Góc : ${a} (Bao gồm góc tù + góc nhọn)');

    var degreesStart = degrees(startAngle);
    var degreesEnd = degrees(endAngle);

    // if (degreesEnd < 0) {
    //   degreesEnd = 360 + degreesEnd;
    // }

    // if (degreesStart < 0) {
    //   degreesStart = 360 + degreesStart;
    // }
    print(
        'startDegreesAft radians: ${radians(degreesStart)}, degrees: ${degreesStart}');
    print(
        'endDegreesAft radians: ${radians(degreesEnd)}, degrees: ${degreesEnd}');
    //Test Draw ARC
    var rectTest = Rect.fromCircle(center: Offset(100, 100), radius: 30);
    var rectTest2 = Rect.fromCircle(center: Offset(200, 100), radius: 30);

    // canvas.drawArc(
    //     rectTest,
    //     0, //radians
    //     -1.5 * pi, //radians
    //     true,
    //     anglePaint);

    // canvas.drawArc(
    //     rectTest2,
    //     0, //radians
    //     1.5 * pi, //radians
    //     true,
    //     anglePaint);
    if (a > 180) {
      print('Real angle: ${360 - a}');
      // canvas.drawArc(rect, startAngle, endAngle, true, anglePaint);
      canvas.drawArc(rect, radians(degreesEnd),
          radians(degreesStart) - radians(degreesEnd), true, anglePaint);
    } else {
      print(
          'start Angle: ${startAngle} and end Angle - start Angle: ${endAngle - startAngle}');
      // canvas.drawArc(rect, startAngle, endAngle, true, anglePaint);

      canvas.drawArc(rect, radians(degreesStart),
          radians(degreesEnd) - radians(degreesStart), true, anglePaint);
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
