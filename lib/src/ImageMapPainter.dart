import 'package:flutter/material.dart';

class ImageMapPainter extends CustomPainter {
  final List<Path> shapes;
  final List<Paint> _paint = [];
  final List<Color> colors;
  final Paint blackPaint = Paint()
    ..color = Color.fromRGBO(255, 0, 0, 1)
    ..strokeWidth = 5;
  final Size rawSize;

  bool debug;

  ImageMapPainter(
      {required this.shapes,
      required this.colors,
      required this.rawSize,
      this.debug = false}) {
    for (Color c in this.colors) {
      Paint p = Paint();
      p.color = c;
      _paint.add(p);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    //print("Paint size $size");
    double hScale = size.height / rawSize.height;
    double wScale = size.width / rawSize.width;

    double scale;
    double fitOffsetX = 0.0, fitOffsetY = 0.0;
    if ((wScale - 1.0).abs() > (hScale - 1.0).abs()) {
      scale = wScale;
      fitOffsetY = (size.height - this.rawSize.height * scale) / 2;
    } else {
      scale = hScale;
      fitOffsetX = (size.width - this.rawSize.width * scale) / 2;
    }

    if (debug == true) {
      canvas.drawLine(Offset(0.0, 0.0), Offset(size.width, 0.0), blackPaint);
      canvas.drawLine(Offset(0.0, 0.0), Offset(0.0, size.height), blackPaint);

      canvas.drawLine(
          Offset(size.width, 0.0), Offset(size.width, size.height), blackPaint);
      canvas.drawLine(Offset(0.0, size.height), Offset(size.width, size.height),
          blackPaint);
    }

    canvas.translate(fitOffsetX, fitOffsetY);
    canvas.scale(scale);

    for (int i = 0; i < shapes.length; i++) {
      canvas.drawPath(shapes[i], _paint[i]);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
