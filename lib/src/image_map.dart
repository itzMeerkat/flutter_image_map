import 'package:flutter/material.dart';

import 'package:flutter_image_map/src/image_map_painter.dart';

class ImageMap extends StatefulWidget {
  const ImageMap({
    required this.imagePath,
    required this.imageSize,
    required this.onTap,
    required this.regions,
    required this.regionColors,
    super.key,
    this.isDebug = false,
  });
  final String imagePath;
  final List<Path> regions;
  final List<Color> regionColors;
  final void Function(int) onTap;
  final Size imageSize;
  final bool isDebug;

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
        final b = context.findRenderObject()! as RenderBox;
        final locPos = details.localPosition;
        final widthMul = widget.imageSize.width / b.size.width;
        final heightMul = widget.imageSize.height / b.size.height;
        final rawPos = Offset(locPos.dx * widthMul, locPos.dy * heightMul);
        for (var i = 0; i < widget.regions.length; i++) {
          if (widget.regions[i].contains(rawPos)) {
            widget.onTap(i);
            return;
          }
        }
      },
      child: CustomPaint(
        foregroundPainter: ImageMapPainter(
          shapes: widget.regions,
          colors: widget.regionColors,
          rawSize: widget.imageSize,
          debug: widget.isDebug,
        ),
        child: Image.asset(widget.imagePath),
      ),
    );
  }
}
