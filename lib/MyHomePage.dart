import 'package:flutter/material.dart';
import 'package:unitconverter/ToolPage.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.buildContext}) : super(key: key);

  final BuildContext buildContext;
  static const String routeName = "/myhomepage";


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
              padding: EdgeInsets.all(20.0),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    this.buildContext,
                    ToolPage.routeName,
                  );
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
