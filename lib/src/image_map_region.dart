import 'package:flutter/material.dart';
import 'package:flutter_image_map/src/image_map_shape.dart';

class ImageMapRegion {
  const ImageMapRegion({
    required this.shape,
    required this.path,
    required this.color,
  });

  factory ImageMapRegion.fromRect(Rect rect, Color color) {
    return ImageMapRegion(
      shape: ImageMapShape.rect,
      path: Path()..addRect(rect),
      color: color,
    );
  }

  factory ImageMapRegion.fromPoly(List<Offset> points, Color color) {
    return ImageMapRegion(
      shape: ImageMapShape.poly,
      path: Path()..addPolygon(points, true),
      color: color,
    );
  }

  factory ImageMapRegion.fromCircle(Offset center, double radius, Color color) {
    return ImageMapRegion(
      shape: ImageMapShape.circle,
      path: Path()..addOval(Rect.fromCircle(center: center, radius: radius)),
      color: color,
    );
  }

  final ImageMapShape shape;
  final Path path;
  final Color color;
}
