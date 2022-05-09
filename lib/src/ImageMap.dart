import 'package:flutter/material.dart';

import 'ImageMapPainter.dart';

class ImageMap extends StatefulWidget {
  final String imagePath;
  final List<Path> regions;
  final List<Color> regionColors;
  final void Function(int) onTap;
  final Size imageSize;
  final bool isDebug;
  ImageMap(
      {Key? key,
      required this.imagePath,
      required this.imageSize,
      required this.onTap,
      required this.regions,
      required this.regionColors,
      this.isDebug = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ImageMapState();
  }
}

class ImageMapState extends State<ImageMap> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (details) {
          RenderBox b = context.findRenderObject() as RenderBox;
          Offset locPos = details.localPosition;
          double widthMul = widget.imageSize.width / b.size.width;
          double heightMul = widget.imageSize.height / b.size.height;
          Offset rawPos = Offset(locPos.dx * widthMul, locPos.dy * heightMul);
          for (int i = 0; i < widget.regions.length; i++) {
            if (widget.regions[i].contains(rawPos)) {
              widget.onTap(i);
              return;
            }
          }
        },
        child: CustomPaint(
            child: Image.asset(widget.imagePath),
            foregroundPainter: ImageMapPainter(
                shapes: widget.regions,
                colors: widget.regionColors,
                rawSize: widget.imageSize,
                debug: widget.isDebug)));
  }
}
