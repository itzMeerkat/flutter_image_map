import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ImageMapPainter extends CustomPainter {
  final List<Path> shapes;
  final List<Paint> _paint = List();
  final List<Color> colors;
  final Paint blackPaint = Paint()
      ..color = Color.fromRGBO(0, 0, 0, 1)
      ..strokeWidth=1;
  ui.Image bkImage;

  bool debug = true;

  ImageMapPainter(
      {@required this.shapes, @required this.colors, @required this.bkImage, this.debug=true}) {
    for (Color c in this.colors) {
      Paint p = Paint();
      p.color = c;
      _paint.add(p);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    double hScale = size.height / bkImage.height;
    double wScale = size.width / bkImage.width;

    double scale;
    double fitOffsetX = 0.0, fitOffsetY = 0.0;
    if ((wScale - 1.0).abs() > (hScale - 1.0).abs()) {
      scale = wScale;
      fitOffsetY = (size.height - this.bkImage.height * scale) / 2;
    } else {
      scale = hScale;
      fitOffsetX = (size.width - this.bkImage.width * scale) / 2;
    }
    
    if(debug == true) {
      canvas.drawLine(Offset(0.0, 0.0), Offset(size.width, 0.0), blackPaint);
      canvas.drawLine(Offset(0.0, 0.0), Offset(0.0, size.height), blackPaint);

      canvas.drawLine(Offset(size.width, 0.0), Offset(size.width, size.height), blackPaint);
      canvas.drawLine(Offset(0.0, size.height), Offset(size.width, size.height), blackPaint);
    }

    canvas.translate(fitOffsetX, fitOffsetY);
    canvas.scale(scale);
    canvas.drawImage(this.bkImage, Offset.zero, Paint());

    for (int i = 0; i < shapes.length; i++) {
      canvas.drawPath(shapes[i], _paint[i]);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
