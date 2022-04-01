import 'package:flutter/material.dart';
import 'package:unitconverter/ToolPage.dart';

class UnitsPage extends StatelessWidget {

  const UnitsPage({Key? key, required this.buildContext,}) : super(key: key);

  final BuildContext buildContext;
  static const String routeName = "/unitpage";

  Widget getUnitCard({String? conversion, required BuildContext buildContext}) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.black,
          width: 10.0,
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFD7218), Color(0xFFFFA66D)],
        ),
      ),
      child: OutlinedButton(
        onPressed: () {
          // Navigator.push(
          //   buildContext,
          //   MaterialPageRoute(builder: (context) => ()),
          // );
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
                Text(
                  conversion!,
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
    final receivedConversion =
    ModalRoute.of(context)!.settings.arguments as String;
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text(
            'Unit Conversions',
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getUnitCard(buildContext: context, conversion: receivedConversion,),
            ],
          ),
        ),
      ),
    );
  }
}
