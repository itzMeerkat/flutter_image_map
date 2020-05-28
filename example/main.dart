import 'package:flutter/material.dart';
import '../lib/flutter_image_map.dart';

void main() => runApp(MyApp());
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ImageMapExample();
  }
}

class ImageMapExample extends State<MyApp> {
  static List<List<Offset>> points = [
    [
      Offset(178, 152),
      Offset(148, 179),
      Offset(125, 173),
      Offset(129, 191),
      Offset(87, 191),
      Offset(130, 226),
      Offset(121, 270),
      Offset(182, 285),
      Offset(185, 272),
      Offset(219, 276),
      Offset(239, 260),
      Offset(218, 225),
      Offset(245, 186),
    ]
  ];
  final List<Path> polygonRegions = points.map((e){
    Path p = Path();
    p.addPolygon(e, true);
    return p;}
  ).toList();
  final List<Color> colors = List.generate(points.length, (index) => Color.fromRGBO(50, 50, 200, 0.5));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("flutter_image_map Example")
        ),
        body: ImageMap(
          imagePath: 'assets/worldmap.png',
          imageSize: Size(698,566),
          onTap: (i){
            colors[i] = colors[i]==Color.fromRGBO(50, 50, 200, 0.5)?Color.fromRGBO(50, 200, 50, 0.5):Color.fromRGBO(50, 50, 200, 0.5);
            print(i);
            setState(() {});
          },
          regions: polygonRegions,
          regionColors: colors
        )
      )
    );
  }
}