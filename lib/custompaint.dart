import 'dart:math';

import 'package:flutter/material.dart';

extension on num {
  double get toRad => this * 0.01745329;
}

class CustomPaintExample extends StatefulWidget {
  const CustomPaintExample({Key? key}) : super(key: key);

  @override
  State<CustomPaintExample> createState() => _CustomPaintExampleState();
}

class _CustomPaintExampleState extends State<CustomPaintExample> {


  Stream<DateTime> dateStream()  async* {
    yield* Stream.periodic(Duration(seconds: 1), (value) {
      print(DateTime.now().toIso8601String());
      return DateTime.now();
    });
  }

  @override
  void initState() {
    print('init called');
    dateStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Custom Paint'),),
      body: Center(
        child: StreamBuilder<DateTime>(
            stream: dateStream(),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                return Stack(
                  children: [
                    CustomPaint(
                      painter: ClockPainter(),
                      child: Container(
                        width: 200,
                        height: 200,
                      ),
                    ),
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(((snapshot.data!.hour * 30) + (snapshot.data!.second * 0.0083)).toRad),
                      child: CustomPaint(
                        painter: HourHandPainter(),
                        child: Container(
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ),
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(((snapshot.data!.minute * 6) + (snapshot.data!.second * 0.1)).toRad),
                      child: CustomPaint(
                        painter: MinuteHandPainter(),
                        child: Container(
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ),
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ((snapshot.data!.second * 6).toRad),
                      child: CustomPaint(
                        painter: SecondHandPainter(),
                        child: Container(
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return SizedBox();
            }
        ),
      ),
    );
  }


}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      .. color = Colors.blue
      .. style = PaintingStyle.stroke
      .. strokeWidth = 5.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;
    canvas.drawCircle(center, radius, paint);
    paint.style = PaintingStyle.fill;
    paint.strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius * 0.05, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SecondHandPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      .. color = Colors.blue
      .. style = PaintingStyle.fill
      .. strokeWidth = 5.0 .. strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;
    final startOffset = Offset(center.dx, radius * 0.10);
    final endOffset = Offset(center.dx, center.dy + radius * 0.20);
    canvas.drawLine(startOffset, endOffset, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}



class MinuteHandPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      .. color = Colors.blue
      .. style = PaintingStyle.fill
      .. strokeWidth = 5.0 .. strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;
    final startOffset = Offset(center.dx, radius * 0.40);
    final endOffset = Offset(center.dx, center.dy + radius * 0.20);
    canvas.drawLine(startOffset, endOffset, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class HourHandPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      .. color = Colors.blue
      .. style = PaintingStyle.fill
      .. strokeWidth = 5.0 .. strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;
    final startOffset = Offset(center.dx, radius * 0.60);
    final endOffset = Offset(center.dx, center.dy + radius * 0.20);
    canvas.drawLine(startOffset, endOffset, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
