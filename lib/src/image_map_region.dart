import 'package:flutter/material.dart';
import 'package:flutter_image_map/src/image_map_shape.dart';

class ImageMapRegion {
  const ImageMapRegion({
    required this.shape,
    required this.path,
    this.color = Colors.transparent,
    this.title,
    this.link,
  });

  factory ImageMapRegion.fromRect({
    required Rect rect,
    Color? color,
    String? title,
    String? link,
  }) {
    return ImageMapRegion(
      shape: ImageMapShape.rect,
      path: Path()..addRect(rect),
      color: color ?? Colors.transparent,
      title: title,
      link: link,
    );
  }

  factory ImageMapRegion.fromPoly({
    required List<Offset> points,
    Color? color,
    String? title,
    String? link,
  }) {
    return ImageMapRegion(
      shape: ImageMapShape.poly,
      path: Path()..addPolygon(points, true),
      color: color ?? Colors.transparent,
      title: title,
      link: link,
    );
  }

  factory ImageMapRegion.fromCircle({
    required Offset center,
    required double radius,
    Color? color,
    String? title,
    String? link,
  }) {
    return ImageMapRegion(
      shape: ImageMapShape.circle,
      path: Path()
        ..addOval(
          Rect.fromCircle(
            center: center,
            radius: radius,
          ),
        ),
      color: color ?? Colors.transparent,
      title: title,
      link: link,
    );
  }

  final ImageMapShape shape;
  final Path path;
  final Color color;
  final String? title;
  final String? link;

  static List<ImageMapRegion> fromHtml(
    String data, [
    Color? color,
  ]) {
    final regions = <ImageMapRegion>[];
    final areaMatches = RegExp(
      r'<area .+>',
      caseSensitive: false,
      multiLine: true,
    ).allMatches(data);

    final shapeRegex = RegExp(
      r'shape="([^"]+)"',
      caseSensitive: false,
    );
    final coordsRegex = RegExp(
      r'coords="([^"]+)"',
      caseSensitive: false,
    );
    final titleRegex = RegExp(
      r'title="([^"]+)"',
      caseSensitive: false,
    );
    final linkRegex = RegExp(
      r'href="([^"]+)"',
      caseSensitive: false,
    );

    for (final areaMatch in areaMatches) {
      final areaValue = areaMatch.group(0);
      if (areaValue == null) {
        continue;
      }
      final shapeMatch = shapeRegex.firstMatch(areaValue);
      final coordsMatch = coordsRegex.firstMatch(areaValue);
      if (shapeMatch == null || coordsMatch == null) {
        continue;
      }

      final titleMatch = titleRegex.firstMatch(areaValue);
      final linkMatch = linkRegex.firstMatch(areaValue);

      final shape = ImageMapShape.fromString(shapeMatch.group(1)!);
      final coords = coordsMatch
          .group(1)!
          .split(',')
          .map(double.parse)
          .toList(growable: false);

      switch (shape) {
        case ImageMapShape.rect:
          regions.add(
            ImageMapRegion.fromRect(
              rect: Rect.fromLTRB(
                coords[0],
                coords[1],
                coords[2],
                coords[3],
              ),
              color: color,
              title: titleMatch?.group(1),
              link: linkMatch?.group(1),
            ),
          );
          break;
        case ImageMapShape.poly:
          final offsets = <Offset>[];
          for (var i = 0; i < coords.length; i += 2) {
            final x = coords[i];
            final y = coords[i + 1];
            offsets.add(Offset(x, y));
          }
          regions.add(
            ImageMapRegion.fromPoly(
              points: offsets,
              color: color,
              title: titleMatch?.group(1),
              link: linkMatch?.group(1),
            ),
          );
          break;
        case ImageMapShape.circle:
          regions.add(
            ImageMapRegion.fromCircle(
              center: Offset(
                coords[0],
                coords[1],
              ),
              radius: coords[2],
              color: color,
              title: titleMatch?.group(1),
              link: linkMatch?.group(1),
            ),
          );
          break;
      }
    }

    return regions;
  }
}
