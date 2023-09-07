enum ImageMapShape { rect, poly, circle }

ImageMapShape getImageMapShapeFromString(String name) {
  switch (name) {
    case 'rect':
      return ImageMapShape.rect;
    case 'poly':
      return ImageMapShape.poly;
    case 'circle':
      return ImageMapShape.circle;
  }

  throw Exception('Unsupported shape: $name');
}
