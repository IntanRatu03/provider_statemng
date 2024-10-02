import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ColorController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<ColorController>(
        builder: (context, colorController, child) {
          return ColorControllerWidget(colorController: colorController);
        },
      ),
    );
  }
}

class ColorController with ChangeNotifier {
  double _red = 125.0;
  double _green = 125.0;
  double _blue = 125.0;

  double get red => _red;
  double get green => _green;
  double get blue => _blue;

  String getHexColor() {
    int r = _red.toInt();
    int g = _green.toInt();
    int b = _blue.toInt();
    
    return '#${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}'.toUpperCase();
  }

  void updateRed(double value) {
    _red = value;
    notifyListeners();
  }

  void updateGreen(double value) {
    _green = value;
    notifyListeners();
  }

  void updateBlue(double value) {
    _blue = value;
    notifyListeners();
  }
}

class ColorControllerWidget extends StatelessWidget {
  final ColorController colorController;

  ColorControllerWidget({required this.colorController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter RGB Controller'),
        backgroundColor: Color.fromRGBO(
          colorController.red.toInt(),
          colorController.green.toInt(),
          colorController.blue.toInt(),
          1,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Color Controller',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ColorSlider('R', colorController.red, (value) {
              colorController.updateRed(value);
            }),
            SizedBox(height: 20),
            ColorSlider('G', colorController.green, (value) {
              colorController.updateGreen(value);
            }),
            SizedBox(height: 20),
            ColorSlider('B', colorController.blue, (value) {
              colorController.updateBlue(value);
            }),
            SizedBox(height: 20),
            Container(
              width: 100,
              height: 100,
              color: Color.fromRGBO(
                colorController.red.toInt(),
                colorController.green.toInt(),
                colorController.blue.toInt(),
                1,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Hex Color: ${colorController.getHexColor()}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorSlider extends StatelessWidget {
  final String label;
  final double value;
  final Function(double) onChanged;

  ColorSlider(this.label, this.value, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        Expanded(
          child: Slider(
            value: value,
            min: 0,
            max: 255, 
            onChanged: onChanged,
          ),
        ),
        Text(value.toStringAsFixed(0)),  
      ],
    );
  }
}