import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      home: MyHomePage(buildContext: context),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.buildContext}) : super(key: key);

  final BuildContext buildContext;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _validate = false;
  String? _inputName = '';
  TextEditingController _text = TextEditingController();

  void setName() {
    String name = _text.text;
    saveNamePreference(name);
    saveCSVPreference(name);
  }

  Future<void> saveNamePreference(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("name", name);
  }

  Future<void> saveCSVPreference(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final directory = await getApplicationDocumentsDirectory();
    String filename = directory.path + '/$name.csv';
    String file = "$filename";
    preferences.setString("path", file);
    File f = new File(file);
    f.writeAsString('Conversion,FirstUnit,SecondUnit');
  }

  // Future<void> getNamePreference() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String? name = preferences.getString("name");
  // }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green, Colors.orange],
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                'Unit Converter',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'BreeSerif',
                  fontFamilyFallback: ['Roboto', 'Cupertino'],
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(5.0),
              child: TextField(
                controller: _text,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.transparent,
                  labelText: 'Enter Name',
                  hintText: 'John Doe',
                  errorText: _validate ? 'Username Can\'t Be Empty' : null,
                ),
                onChanged: (text) {
                  _inputName = text;
                  if (_inputName != null && _inputName != '')
                    _validate = true;
                  setName();
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_validate == true)
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ToolPage(buildContext: context)),
                      );
                  });
                },
                child: Text(
                    'Open'
                ),
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(Size.square(50.0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(10.0)
                  ),
                  alignment: Alignment.center,
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ToolPage extends StatefulWidget {
  const ToolPage({Key? key, required this.buildContext}) : super(key: key);

  final BuildContext buildContext;

  @override
  State<ToolPage> createState() => _ToolPageState();
}

class _ToolPageState extends State<ToolPage> {
  String? _name;

  void getName() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    _name = preferences.getString("name");
    setState(() {});
  }

  @override
  void initState() {
    getName();
    super.initState();
  }

  Widget getConversionCard({required String conversion, required String convIcon, required BuildContext context}) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFD7218), Color(0xFFFC8A40)],
        ),
      ),
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UnitsPage(buildContext: context, conversion: conversion)),
          );
        },
        style: ButtonStyle(
          alignment: Alignment.center,
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          minimumSize: MaterialStateProperty.all<Size>(Size(150, 125)),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(5.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(convIcon, scale: 10.0,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  conversion,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'BreeSerif',
                    fontFamilyFallback: ['Roboto', 'Cupertino'],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text(
              'Conversions Menu',
              style: TextStyle(
                fontFamily: 'BreeSerif',
                fontFamilyFallback: [
                  'Roboto',
                  'Cupertino',
                ],
                fontWeight: FontWeight.bold ,
              ),
            ),
            centerTitle: true,
          ),
          body: ListView(
            padding: EdgeInsets.all(20.0),
            children: [
              Text(
                'Hello, $_name',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'BreeSerif',
                  fontFamilyFallback: ['Roboto', 'Cupertino'],
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Please select a conversion.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'BreeSerif',
                  fontFamilyFallback: ['Roboto', 'Cupertino'],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  getConversionCard(conversion: 'Volume', convIcon: 'assets/images/volume.png', context: context),
                  getConversionCard(conversion: 'Length', convIcon: 'assets/images/ruler.png', context: context),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getConversionCard(conversion: 'Weight', convIcon: 'assets/images/scale.png', context: context),
                  getConversionCard(conversion: 'Area', convIcon: 'assets/images/area.png', context: context),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getConversionCard(conversion: 'Temperature', convIcon: 'assets/images/thermometer.png', context: context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class UnitsPage extends StatelessWidget {

  const UnitsPage({Key? key, required this.buildContext, required this.conversion}) : super(key: key);

  final BuildContext buildContext;
  final String conversion;

  List<dynamic> getUnits({required String conversion}) {
    List unitList = [];
    if (conversion == 'Volume') {
      unitList = ['Liters', 'Gallons'];
    }
    if (conversion == 'Area') {
      unitList = ['Square Meters', 'Square Feet'];
    }
    if (conversion == 'Temperature') {
      unitList = ['Celsius', 'Fahrenheit'];
    }
    if (conversion == 'Weight') {
      unitList = ['Kilograms', 'Pounds'];
    }
    if (conversion == 'Length') {
      unitList = ['Meters', 'Feet'];
    }
    return unitList;
  }

  Widget getUnitCard({required BuildContext context, required String firstUnit, required String secondUnit}) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFD7218), Color(0xFFFFA66D)],
        ),
      ),
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SliderPage(buildContext: buildContext,conversion: conversion, firstUnit: firstUnit, secondUnit: secondUnit)),
          );
        },
        style: ButtonStyle(
          alignment: Alignment.center,
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          minimumSize: MaterialStateProperty.all<Size>(Size(150, 125)),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(5.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  firstUnit,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'BreeSerif',
                    fontFamilyFallback: ['Roboto', 'Cupertino'],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.wifi_protected_setup,
                  color: Colors.white,
                ),
                Text(
                  secondUnit,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'BreeSerif',
                    fontFamilyFallback: ['Roboto', 'Cupertino'],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    List<dynamic> units = getUnits(conversion: conversion);
    String firstUnit = units.elementAt(0);
    String secondUnit = units.elementAt(1);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text(
            conversion,
            style: TextStyle(
              fontFamily: 'BreeSerif',
              fontFamilyFallback: [
                'Roboto',
                'Cupertino',
              ],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              getUnitCard(context: context, firstUnit: firstUnit, secondUnit: secondUnit),
            ],
          ),
        ),
      ),
    );
  }
}


class SliderPage extends StatefulWidget {
  const SliderPage({Key? key, required this.buildContext, required this.conversion, required this.firstUnit, required this.secondUnit}) : super(key: key);

  final BuildContext buildContext;
  final String conversion;
  final String firstUnit;
  final String secondUnit;

  @override
  _SliderPageState createState() => _SliderPageState();
}


class _SliderPageState extends State<SliderPage> {

  double _firstSliderValue = 50;
  double _secondSliderValue = 50;
  RangeValues values = RangeValues(0.0, 1000.0);
  RangeLabels labels = RangeLabels('0', "1000");
  late String _path;

  void getPath() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    _path = preferences.getString("path")!;
    setState(() {});
  }

  Future<File> get _localFile async {
    return File(_path);
  }

  Future<File> writeCounter(String contents) async {
    final file = await _localFile;
    return file.writeAsString('$contents');
  }

  @override
  void initState() {
    getPath();
    super.initState();
  }

  double getConversionKey({required String firstUnit, required String secondUnit}) {
    double conversionKey = 0;
    if (firstUnit == 'Liters') {
      if (secondUnit == 'Gallons')
        conversionKey = 0.2641729;
    }
    if (firstUnit == 'Gallons') {
      if (secondUnit == 'Liters')
        conversionKey = 3.7854;
    }
    if (firstUnit == 'Kilometers') {
      if (secondUnit == 'Miles')
        conversionKey = 0.6213712;
    }
    if (firstUnit == 'Miles') {
      if (secondUnit == 'Kilometers')
        conversionKey = 1.609344;
    }
    if (firstUnit == 'Meters') {
      if (secondUnit == 'Feet')
        conversionKey = 3.2808;
    }
    if (firstUnit == 'Feet') {
      if (secondUnit == 'Meters')
        conversionKey = 0.3048;
    }
    if (firstUnit == 'Kilograms') {
      if (secondUnit == 'Pounds')
        conversionKey = 2.204623;
    }
    if (firstUnit == 'Pounds') {
      if (secondUnit == 'Kilograms')
        conversionKey = 0.4535924;
    }
    if (firstUnit == 'Square Meters') {
      if (secondUnit == 'Square Feet')
        conversionKey = 10.76391;
    }
    if (firstUnit == 'Square Feet') {
      if (secondUnit == 'Square Meters')
        conversionKey = 0.09290304;
    }
    return conversionKey;
  }


  double getTemp({required String firstUnit, required double unitVal}) {
    double conversionKey = 0.0;
    if (firstUnit == 'Celsius')
      conversionKey = (unitVal * 1.8) + 32.0;
    if (firstUnit == 'Fahrenheit')
      conversionKey = (unitVal - 32.0)/1.8;
    return conversionKey;
  }


  Column getSliders({required String conversion, required String firstUnit, required String secondUnit}) {
    double conversionKey = getConversionKey(firstUnit: firstUnit, secondUnit: secondUnit);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFC76B), Color(0xFFFFE4B6)],
            ),
            border: Border.all(
              width: 5.0,
              color: Colors.deepOrange,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Text(
                firstUnit,
                style: TextStyle(
                  fontFamily: 'BreeSerif',
                  fontFamilyFallback: [
                    'Cupertino',
                    'Roboto',
                  ],
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              Text(
                _firstSliderValue.toStringAsFixed(2),
                style: TextStyle(
                  fontFamily: 'BreeSerif',
                  fontFamilyFallback: [
                    'Cupertino',
                    'Roboto',
                  ],
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              Slider(
                value: _firstSliderValue,
                min: 0.0,
                max: 1000.0,
                divisions: 10000,
                label: _firstSliderValue.toStringAsFixed(2),
                activeColor: Colors.deepOrange,
                inactiveColor: Colors.orange,
                onChanged: (newValue) {
                  setState(() {
                    _firstSliderValue = newValue;
                    _secondSliderValue = newValue * conversionKey;
                  });
                },
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFC76B), Color(0xFFFFE4B6)],
            ),
            border: Border.all(
              width: 5.0,
              color: Colors.deepOrange,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Text(
                secondUnit,
                style: TextStyle(
                  fontFamily: 'BreeSerif',
                  fontFamilyFallback: [
                    'Cupertino',
                    'Roboto',
                  ],
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              Text(
                _secondSliderValue.toStringAsFixed(2),
                style: TextStyle(
                  fontFamily: 'BreeSerif',
                  fontFamilyFallback: [
                    'Cupertino',
                    'Roboto',
                  ],
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              Slider(
                value: _secondSliderValue,
                min: 0.0,
                max: 1000.0 * conversionKey,
                divisions: 10000,
                label: _secondSliderValue.toStringAsFixed(2),
                activeColor: Colors.deepOrange,
                inactiveColor: Colors.orange,
                onChanged: (newValue) {
                  setState(() {
                    _secondSliderValue = newValue;
                    _firstSliderValue = newValue / conversionKey;
                  });
                },
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            String _conv = widget.conversion;
            String _fval = _firstSliderValue.toString();
            String _sval = _secondSliderValue.toString();
            String first = '$firstUnit:$_fval';
            String second = '$secondUnit:$_sval';
            String _contents = '$_conv,$first,$second';
            writeCounter(_contents);
          },
          child: Text(
            'Save',
            style: TextStyle(
              fontFamily: 'BreeSerif',
              fontFamilyFallback: [
                'Cupertino',
                'Roboto',
              ],
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(10.0)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Conversion',
            style: TextStyle(
              fontFamily: 'BreeSerif',
              fontFamilyFallback: [
                'Cupertino',
                'Roboto',
              ],
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: getSliders(conversion: widget.conversion, firstUnit: widget.firstUnit, secondUnit: widget.secondUnit),
      ),
    );
  }
}
