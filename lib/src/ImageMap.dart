import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ImageMapPainter.dart';

class ImageMap extends StatefulWidget {
  final String imagePath;
  final List<Path> regions;
  final List<Color> regionColors;
  final void Function(int) onTap;

  ImageMap(
      {Key key,
      @required this.imagePath,
      @required this.onTap,
      @required this.regions,
      @required this.regionColors})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ImageMapState();
  }
}

class ImageMapState extends State<ImageMap> {
  ui.Image image;
  bool isImageloaded = false;
  double rawWidth, rawHeight;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<Null> init() async {
    final ByteData data = await rootBundle.load(widget.imagePath);
    image = await loadImage(new Uint8List.view(data.buffer));
    rawHeight = image.height.roundToDouble();
    rawWidth = image.width.roundToDouble();
  }

  Future<ui.Image> loadImage(List<int> img) async {
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      setState(() {
        isImageloaded = true;
      });
      return completer.complete(img);
    });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    if (isImageloaded) {
      return GestureDetector(
          onTapDown: (details) {
            RenderBox b = context.findRenderObject();
            Offset locPos = details.localPosition;
            double widthMul = rawWidth / b.size.width;
            double heightMul = rawHeight / b.size.height;
            Offset rawPos = Offset(locPos.dx * widthMul, locPos.dy * heightMul);
            for (int i = 0; i < widget.regions.length; i++) {
              if (widget.regions[i].contains(rawPos)) {
                widget.onTap(i);
                return;
              }
            }
          },
          child: CustomPaint(
              size: Size(rawWidth, rawHeight),
              painter: ImageMapPainter(
                  shapes: widget.regions,
                  colors: widget.regionColors,
                  bkImage: image)));
    } else {
      return CircularProgressIndicator();
    }
  }
}
