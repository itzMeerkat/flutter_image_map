import 'package:flutter/material.dart';
import 'package:flutter_image_map/flutter_image_map.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SymptomPicker()
    );
  }
}

class SymptomPicker extends StatefulWidget {
  @override
  SymptomPickerState createState() => SymptomPickerState();
}

class SymptomPickerState extends State<SymptomPicker> {
  
  List<List<double>> v = [
      [118,0,82,26,93,118,155,118,163,26],
      [58,171,57,331,192,331,194,171]
    ];
  double rawWidth = 250, rawHeight = 765;

  @override
  Widget build(BuildContext context) {
    List<Path> regions = new List();
    for(var i in v) {
      List<Offset> t = new List();
      for(int j=0;j<i.length;j+=2) {
        t.add(Offset(i[j],i[j+1]));
      }
      Path tp = new Path();
      tp.addPolygon(t, true);
      regions.add(tp);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.navigate_before), onPressed: () => {}),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.cancel), onPressed: () => {})
        ]),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[Text("Left"),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: ImageMap(
              imagePath: 'assets/male-front-raw.png', 
              onTap: (i) {
                print(i);
                }, 
              rawRegions: regions,
              rawWidth: rawWidth,
              rawHeight: rawHeight
            )
          ),
          Text("Right")
        ]
        )
    );
  }
}