import 'package:flutter/material.dart';
import 'package:gesture_x_detector/gesture_x_detector.dart';
import 'package:test2/MyLine.dart';

void main() {
  runApp(
    MaterialApp(
      home: XGestureExample(),
    ),
  );
}

class XGestureExample extends StatefulWidget {
  @override
  _XGestureExampleState createState() => _XGestureExampleState();
}

class _XGestureExampleState extends State<XGestureExample> {
  String lastEventName = 'Tap on screen';
  Offset xPos = Offset(150, 250);
  Offset yPos = Offset(150, 350);
  Offset zPos = Offset(50, 400);

  // Widget drawLine = Draw_Line(Offset(0, 0), Offset(0, 100));
  // List<Widget> listings = [];
  @override
  Widget build(BuildContext context) {
    return Material(
      child: DrawLine(a: xPos, b: yPos, c: zPos),
      // child: Stack(
      //   children: [
      //     DrawLine(a: xPos, b: yPos),
      //     // CustomPaint(
      //     //     painter: MyLine(
      //     //         a: xPos,
      //     //         b: yPos,
      //     //         sideColor: Color(0xfff60404),
      //     //         sideWidth: 5)),
      //     //     ...listLine,
      //   ],
      // ),
    );
  }

  void onScrollEvent(ScrollEvent event) {
    setLastEventName('onLongPressMove');
    print('scrolling - pos: ${event.localPos} delta: ${event.scrollDelta}');
  }

  void onLongPressMove(MoveEvent event) {
    setLastEventName('onLongPressMove');
    print('onMoveUpdate - pos: ${event.localPos} delta: ${event.delta}');
  }

  void onLongPressEnd() {
    setLastEventName('onLongPressEnd');
    print('onLongPressEnd');
  }

  void onScaleEnd() {
    setLastEventName('onScaleEnd');
    print('onScaleEnd');
  }

  void onScaleUpdate(ScaleEvent event) {
    setLastEventName('onScaleUpdate');
    print(
        'onScaleUpdate - changedFocusPoint:  ${event.focalPoint} ; scale: ${event.scale} ;Rotation: ${event.rotationAngle}');
  }

  void onScaleStart(initialFocusPoint) {
    setLastEventName('onScaleStart');
    print('onScaleStart - initialFocusPoint: $initialFocusPoint');
  }

  void onMoveUpdate(MoveEvent event) {
    setLastEventName('onMoveUpdate');
    setState(() {
      yPos = event.localPos;
      //listLine.isNotEmpty(index, element)
    });
    print('onMoveUpdate - pos: ${event.localPos} delta: ${event.delta}');
  }

  void onMoveEnd(MoveEvent event) {
    setLastEventName('onMoveEnd');

    // listLine.add(DrawLine(a: xPos, b: yPos));
    print('onMoveEnd - pos: $yPos');
  }

  void onMoveStart(MoveEvent event) {
    setLastEventName('onMoveStart');
    xPos = event.localPos;

    // Draw_Line(Offset(0, 0), Offset(0, 100)).test();
    print('onMoveStart - pos: $xPos');
  }

  void onLongPress(TapEvent event) {
    setLastEventName('onLongPress');

    // listings.add(drawLine);

    print('onLongPress - pos: ${event.localPos}');
  }

  void onDoubleTap(event) {
    setLastEventName('onDoubleTap');
    print('onDoubleTap - pos: ' + event.localPos.toString());
  }

  void onTap(event) {
    setLastEventName('onTap');
    print('onTap - pos: ' + event.localPos.toString());
  }

  void setLastEventName(String eventName) {
    setState(() {
      lastEventName = eventName;
    });
  }
}

class DrawLine extends StatefulWidget {
  Offset a = Offset(0, 0);
  Offset b = Offset(0, 0);
  Offset c = Offset(0, 0);

  DrawLine(
      {this.a = const Offset(0, 0),
      this.b = const Offset(0, 0),
      this.c = const Offset(0, 0)});

  @override
  _DrawLineState createState() => _DrawLineState();
}

class _DrawLineState extends State<DrawLine> {
  Offset startLine = Offset(0, 0);
  Offset endLine = Offset(0, 0);
  var listLine = [];
  @override
  Widget build(BuildContext context) {
    return XGestureDetector(
      child: Material(
          child: Stack(
        children: [
          CustomPaint(
            painter: MyAngle(a: startLine, b: endLine),
          ),
          ...listLine
        ],
      )
          // child: Stack(
          //     //Rotate triangle
          //     children: [
          //   CustomPaint(
          //       // painter: MyLine(
          //       //     a: widget.a,
          //       //     b: widget.b,
          //       //     sideColor: Color(0xfff60404),
          //       //     sideWidth: 5)),
          //       // painter: MyAngle(a: widget.a, b: widget.b, c: widget.c)
          //       ),
          //   // CustomPaint(
          //   //     painter: MyCircle(
          //   //   center: widget.a,
          //   // )),
          //   // CustomPaint(
          //   //     painter: MyCircle(
          //   //   center: widget.b,
          //   // )),
          //   // CustomPaint(
          //   //     painter: MyCircle(
          //   //   center: widget.c,
          //   // ))
          // ])
          ),
      doubleTapTimeConsider: 300,
      longPressTimeConsider: 350,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onLongPressEnd: onLongPressEnd,
      onMoveStart: onMoveStart,
      onMoveEnd: onMoveEnd,
      onMoveUpdate: onMoveUpdate,
      onScaleStart: onScaleStart,
      onScaleUpdate: onScaleUpdate,
      onScaleEnd: onScaleEnd,
      bypassTapEventOnDoubleTap: false,
      onLongPressMove: onLongPressMove,
      onScrollEvent: onScrollEvent,
      longPressMaximumRangeAllowed: 25,
    );
  }

  void onScrollEvent(ScrollEvent event) {
    print('scrolling - pos: ${event.localPos} delta: ${event.scrollDelta}');
  }

  void onLongPressMove(MoveEvent event) {
    print('onMoveUpdate - pos: ${event.localPos} delta: ${event.delta}');
  }

  void onLongPressEnd() {
    print('onLongPressEnd');
  }

  void onScaleEnd() {
    print('onScaleEnd');
  }

  void onScaleUpdate(ScaleEvent event) {
    print(
        'onScaleUpdate - changedFocusPoint:  ${event.focalPoint} ; scale: ${event.scale} ;Rotation: ${event.rotationAngle}');
  }

  void onScaleStart(initialFocusPoint) {
    print('onScaleStart - initialFocusPoint: $initialFocusPoint');
  }

  void onMoveUpdate(MoveEvent event) {
    setState(() {
      endLine = event.localPos;
      //listLine.isNotEmpty(index, element)
    });
    print('onMoveUpdate - pos: ${event.localPos} delta: ${event.delta}');
  }

  void onMoveEnd(MoveEvent event) {
    // listLine.add(DrawLine(a: startLine, b: endLine));
    listLine.add(CustomPaint(
      painter: MyAngle(a: startLine, b: endLine),
    ));
    // print(listLine);
    // print('cua Draw Line');
  }

  void onMoveStart(MoveEvent event) {
    startLine = event.localPos;
    // print('cua Draw Line');
  }

  void onLongPress(TapEvent event) {
    // listings.add(drawLine);

    print('onLongPress - pos: ${event.localPos}');
  }

  void onDoubleTap(event) {
    print('onDoubleTap - pos: ' + event.localPos.toString());
  }

  void onTap(event) {
    print('onTap - pos: ' + event.localPos.toString());
  }
}
