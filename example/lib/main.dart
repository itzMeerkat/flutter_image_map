import 'package:flutter/material.dart';
import 'package:flutter_image_map/flutter_image_map.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ImageMapExample();
  }
}

class ImageMapExample extends State<MyApp> {
  bool _tapped = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("flutter_image_map Example")),
        body: ImageMap(
          image: Image.asset('assets/worldmap.png'),
          onTap: (i) {
            // ignore: avoid_print
            print(i);
            setState(() {
              _tapped = !_tapped;
            });
          },
          regions: [
            ImageMapRegion.fromPoly(
              [
                const Offset(178, 152),
                const Offset(148, 179),
                const Offset(125, 173),
                const Offset(129, 191),
                const Offset(87, 191),
                const Offset(130, 226),
                const Offset(121, 270),
                const Offset(182, 285),
                const Offset(185, 272),
                const Offset(219, 276),
                const Offset(239, 260),
                const Offset(218, 225),
                const Offset(245, 186),
              ],
              _tapped
                  ? const Color.fromRGBO(50, 200, 50, 0.5)
                  : const Color.fromRGBO(50, 50, 200, 0.5),
            ),
            ImageMapRegion.fromRect(
              const Rect.fromLTWH(230, 295, 50, 50),
              _tapped
                  ? const Color.fromRGBO(50, 200, 50, 0.5)
                  : const Color.fromRGBO(50, 50, 200, 0.5),
            ),
            ImageMapRegion.fromCircle(
              const Offset(460, 395),
              20,
              _tapped
                  ? const Color.fromRGBO(50, 200, 50, 0.5)
                  : const Color.fromRGBO(50, 50, 200, 0.5),
            )
          ],
        ),
      ),
    );
  }
}
