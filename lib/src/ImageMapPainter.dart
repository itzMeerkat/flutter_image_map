import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ImageMapPainter extends CustomPainter{
  final List<Path> shapes;
  final List<Paint> _paint = List();
  final List<Color> colors;
  ui.Image bkImage;
  ImageMapPainter({
    @required this.shapes,
    @required this.colors,
    @required this.bkImage
  }){
    for(Color c in this.colors) {
      Paint p = Paint();
      p.color = c;
      _paint.add(p);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    double hScale = size.height / bkImage.height;
    double wScale = size.width / bkImage.width;
    //print("$hScale, $wScale");
    //print("$bkImage, $size");
    double scale;
    double fitOffsetX = 0.0, fitOffsetY = 0.0;
    if((wScale-1.0).abs() > (hScale-1.0).abs()) {
      scale = wScale;
      fitOffsetY = (size.height - this.bkImage.height * scale) / 2;
      //print("OffsetY $fitOffsetY");
    } else {
      scale = hScale;
      fitOffsetX = (size.width - this.bkImage.width * scale) / 2;
      //print("OffsetX $fitOffsetX");
    }
    canvas.drawCircle(Offset(0.0,0.0), 10, _paint[0]);
    canvas.drawCircle(Offset(size.width,0.0), 10, _paint[0]);

    canvas.drawCircle(Offset(0.0,size.height), 10, _paint[0]);
    canvas.drawCircle(Offset(size.width,size.height), 10, _paint[0]);
    // print(scale);
    // print(fitOffsetX);
    // print(fitOffsetY);
    
    //canvas.rotate(0.3);
    canvas.translate(fitOffsetX, fitOffsetY);
    canvas.scale(scale);
    canvas.drawImage(this.bkImage, Offset.zero, Paint());
    
    for(int i=0;i<shapes.length;i++) {
      canvas.drawPath(shapes[i], _paint[i]);
    }
    
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

}