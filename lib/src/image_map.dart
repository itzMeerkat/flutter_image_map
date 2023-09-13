import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_image_map/src/image_map_painter.dart';
import 'package:flutter_image_map/src/image_map_region.dart';

class ImageMap extends StatefulWidget {
  const ImageMap({
    required this.image,
    required this.onTap,
    required this.regions,
    Key? key,
    this.isDebug = false,
  }) : super(key: key);
  final Image image;
  final List<ImageMapRegion> regions;
  final void Function(ImageMapRegion) onTap;
  final bool isDebug;

  @override
  State<StatefulWidget> createState() {
    return ImageMapState();
  }
}

class ImageMapState extends State<ImageMap> {
  late Future<ImageInfo> imageFuture;

  @override
  void initState() {
    super.initState();
    imageFuture = getImageInfo(widget.image);
  }

  Future<ImageInfo> getImageInfo(Image img) async {
    final c = Completer<ImageInfo>();

    img.image.resolve(ImageConfiguration.empty).addListener(
          ImageStreamListener(
            (ImageInfo i, bool _) {
              c.complete(i);
            },
            onError: (exception, stackTrace) => c.completeError(exception),
          ),
        );

    return c.future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ImageInfo>(
      future: imageFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: InkWell(
              onTap: () {
                setState(() {
                  imageFuture = getImageInfo(widget.image);
                });
              },
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Icon(
                    Icons.cloud_download,
                    size: 64,
                    color: Colors.grey.shade800,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 48, bottom: 48),
                    child: Icon(
                      Icons.error,
                      size: 20,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        final info = snapshot.data;

        if (info == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return GestureDetector(
          onTapDown: (details) {
            final b = context.findRenderObject()! as RenderBox;
            final locPos = details.localPosition;
            final widthMul = info.image.width / b.size.width;
            final heightMul = info.image.height / b.size.height;
            final rawPos = Offset(locPos.dx * widthMul, locPos.dy * heightMul);
            for (var i = 0; i < widget.regions.length; i++) {
              final obj = widget.regions[i];
              if (obj.path.contains(rawPos)) {
                widget.onTap(obj);
                return;
              }
            }
          },
          child: CustomPaint(
            foregroundPainter: ImageMapPainter(
              shapes: widget.regions.map((e) => e.path).toList(
                    growable: false,
                  ),
              colors: widget.regions.map((e) => e.color).toList(
                    growable: false,
                  ),
              rawSize: Size(
                info.image.width.toDouble(),
                info.image.height.toDouble(),
              ),
              debug: widget.isDebug,
            ),
            child: widget.image,
          ),
        );
      },
    );
  }
}
