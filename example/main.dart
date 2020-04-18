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
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.navigate_before), onPressed: () => {}),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.cancel), onPressed: () => {})
        ]),
      body: Text("Coming Soon")
    );
  }
}