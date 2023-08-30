enum ImageMapShape {
  rect,
  poly,
  circle;

  static ImageMapShape fromString(String name) {
    return ImageMapShape.values.where((element) => element.name == name).first;
  }
}
