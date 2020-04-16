import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter_image_map/src/ImageMapPainter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageMap extends StatefulWidget {
  final String imagePath;
  final List<Path> rawRegions;
  final double rawWidth, rawHeight;

  /// Callback that will be invoked with the index of the tapped region.
  final void Function(int) onTap;
  ImageMap({
    Key key,
    @required this.imagePath,
    @required this.onTap,
    @required this.rawRegions,
    @required this.rawHeight,
    @required this.rawWidth
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ImageMapState();
  }

  
}

class ImageMapState extends State<ImageMap> {
  List<Color> regionColors = List();
  ui.Image image;
  bool isImageloaded = false;
  @override
  void initState() {
    for(int i=0;i<widget.rawRegions.length;i++) {
      regionColors.add(Color.fromRGBO(0, 0, 255, 0.5));
    }
    super.initState();
    init();
  }
  Future <Null> init() async {
    final ByteData data = await rootBundle.load(widget.imagePath);
    image = await loadImage(new Uint8List.view(data.buffer));
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
    return GestureDetector(
      onTapDown: (details){
        RenderBox b = context.findRenderObject();
        Offset locPos = details.localPosition;
        double widthMul = widget.rawWidth/b.size.width;
        double heightMul = widget.rawHeight/b.size.height;
        Offset rawPos = Offset(locPos.dx*widthMul, locPos.dy*heightMul);
        for (int i=0; i < widget.rawRegions.length; i++) {
          if (widget.rawRegions[i].contains(rawPos)) {
            widget.onTap(i);
            setState(() {
              regionColors[i] = regionColors[i] == Color.fromRGBO(255, 0, 0, 0.5)?Color.fromRGBO(0, 0, 255, 0.5):Color.fromRGBO(255, 0, 0, 0.5);
            });
            return;
          }
        }
      },
      child: CustomPaint(
            size: Size(250, 765),
            
            painter:ImageMapPainter(shapes: widget.rawRegions, colors: regionColors, bkImage: image)
            )


    );
  }
}