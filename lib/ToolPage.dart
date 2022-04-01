import 'package:flutter/material.dart';
import 'package:unitconverter/UnitsPage.dart';

class ToolPage extends StatelessWidget {
  const ToolPage({Key? key, required this.buildContext}) : super(key: key);

  final BuildContext buildContext;
  static const String routeName = "/toolpage";


  Widget getConversionCard({required String conversion, required String convIcon, required BuildContext buildContext}) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFD7218), Color(0xFFFC8A40)],
        ),
      ),
      child: OutlinedButton(
        onPressed: () {
          Navigator.pushNamed(
            buildContext,
            UnitsPage.routeName,
            arguments: conversion,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  getConversionCard(conversion: 'Volume', convIcon: 'assets/images/volume.png', buildContext: context),
                  getConversionCard(conversion: 'Length', convIcon: 'assets/images/ruler.png', buildContext: context),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getConversionCard(conversion: 'Weight', convIcon: 'assets/images/scale.png', buildContext: context),
                  getConversionCard(conversion: 'Area', convIcon: 'assets/images/area.png', buildContext: context),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getConversionCard(conversion: 'Temperature', convIcon: 'assets/images/thermometer.png', buildContext: context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}